# -*- coding: utf-8 -*-
'''
xstream data log & process v1.0

---------------------------------
run():
	example:
	run(192.168.2.1, 60, 'log_data', 6000, ['ch1, ch2'])
	run(clm=['ch1_CO, ch2_NO'])

	setup connection to the specified ip_address, then fetch data

	Instructions:
	-------------------------------------------------
	ip_addr: 			
	default = '192.168.2.88',	ip_address
	-------------------------------------------------
	sample_interval: 	
	default = 0.5sec,			signal sample freq
	-------------------------------------------------
	file_dir:			
	default = 'sr_data',		direction for file stored
	-------------------------------------------------
	start_reg:
	default = 6000,				first register
	-------------------------------------------------
	clm:				
	default = None,				channel name
	-------------------------------------------------

===================================================================

getLog():
	example:
	getLog()
	getLog('sr_data', '192.168.2.2)

	handle path & dir
	get Log at ip_address
	-------------------------------------------------
	file_dir:
	default:	'sr_data', logging file direction
	-------------------------------------------------
	ip_addr: 			
	default:	'192.168.2.88',	ip_address
	-------------------------------------------------

	return:		DataFrame for the specified ip_addr
	
===================================================================

showInfo():
	show the infomation of the DataFrame: df

===================================================================

	draw DataFrame: df, select the columns which to draw by selection
	chart(df, [1,3,5])
	default as None, means draw all columns

'''

from time import sleep
from pymodbus3.client.sync import ModbusTcpClient as mc
from struct import pack, unpack
from dateutil.parser import parse
from glob import glob
from ctypes import c_uint as uint
from pylab import *

import pandas as pd
import pickle as pk
import os
import zlib
import sys
from pipe import *
from datetime import datetime

def run(idx):
	'''
	'''
	cfg = loadc('config.cdt')
	ds = cfg[cfg.index==idx]
	arr = ds.get_values()[0]
	ip_addr	= arr[0]
	port	= arr[1]
	interval = arr[2]
	regs = arr[3].split(',')
	clm = arr[4].split(',')

	rslt = []
	cnt = 0

	file_dir = ip_addr+'@'+get_hash(idx)
	if not os.path.isdir(file_dir):
		os.mkdir(file_dir)

	client = mc(ip_addr, 502)
	client.connect()


############################################################################################
	try:
		while True:
			dt = datetime.now()

			ds = []
			for string in regs:
				string = string.split(':')
				reg = int(string[0])
				num = int(string[1])
				rr = client.read_holding_registers(reg, num).registers
				data = [rr[i*2+1]*0x10000+rr[i*2] for i in range(int(len(rr)/2))]
				ds += data

			ds = ds|select(lambda x: decf(x))|as_list
			ds = [dt] + ds

			print(ds)
			rslt.append(ds)
			print('----------------------\n')
############################################################################################
			cnt += 1
			if cnt == 7200:
				cnt = 0
				print('Saving file...')
				fn = file_dir + '/%s'%get_hash(dt) + '.cdt'
				df = pd.DataFrame(rslt)
				df.index = df[0]
				del df[0]
				df.columns = clm
				df.index.name = 'date-time'
				dumpc(fn, df)
				print('File saved')

				rslt = []

			sleep(interval)

	except KeyboardInterrupt:
		print('KeyboardInterrupt!')
	finally:
		print('Saving file...')
		fn = file_dir + '/%s'%get_hash(dt) + '.cdt'
		df = pd.DataFrame(rslt)
		df.index = df[0]
		del df[0]
		df.columns = clm
		df.index.name = 'date-time'
		dumpc(fn, df)
		print('File saved.')

def get_hash(obj):
	return hex(hash(str(obj))+2**32)[2:-1]
def get_hash2(obj):
	return hex(uint(hash(obj)))

def decf(d):
	f = unpack('f', pack('I', d))[0]
	return f

def chart(identifier, begin='2000-1-1 00:00', end='2199-1-1', selection=None):
	'''
	draw DataFrame: df, select the columns which to draw by selection
	chart(df, [1,3,5])
	default as None, means draw all columns
	'''
	if type(identifier)==int:
		df = getLog(identifier)
	else:
		df = identifier.sort_index()


	if selection != None:
		df = df.iloc[:, selection]
	df = df[df.index >= begin]
	df = df[df.index <= end]

	chnum = len(df.columns)
	ss = chnum*100+10
	i = 1
	for x in df:
		dd = df[x]
		clr = '#'+hex(hash(x)&0x00ffffff)[2:]
		sb = subplot(ss+i)
		sb.clear()
		sb.plot(df[x], color = clr)
		sb.grid(1)
		sb.set_xlabel('date-time')
		sb.set_ylabel(x)
		i+=1

def getLog(config_num):
	'''

	'''
	cfg = loadc('config.cdt')
	ip_addr = cfg[cfg.index == config_num].iloc[0,0]
	h = get_hash(config_num)
	print('get Log in %d, hash is: %s'%(config_num, h))

	log_dir = ip_addr+'@'+h
	dl = os.listdir(log_dir)

	fns = dl
	df_list = []
	for fn in fns:
		df_list.append(loadc(log_dir + '/' + fn))

	return pd.concat(df_list).sort_index()

def dumpc(fn, data):
	cd = zlib.compress(pk.dumps(data))
	with open(fn, 'wb') as f:
		f.write(cd)

def loadc(fn):
	with open(fn, 'rb') as f:
		cd = f.read()
	return pk.loads(zlib.decompress(cd))

def help():
	print(__doc__)

def showConfigInfo():
	'''
	show the infomation of the global configuration
	'''
	cfg = loadc('config.cdt')
	return(str(cfg)+'\n'*3)

def newConfig():
	'''
	create new config interactively.
	'''
	print('*'*64)
	print('*'+' '*62+'*')
	string1 = 'Now is creating a new config interactively!!'
	string2 = 'One questiong, One answer!'
	d1 = (64-len(string1))/2-1
	d2 = (64-len(string2))/2-1
	print('*'+' '*d1+string1+' '*d1+'*')
	print('*'+' '*d2+string2+' '*d2+'*')	
	print('*'+' '*62+'*')
	print('*'*64)
	sleep(1)

	#load config.cdt file
	cfg_df = loadc('config.cdt')

	while(True):
		print('Let us begin:')
		print('\nstep: 1/5')
		print('ip address & port')
		print('default ip address is "192.168.2.88", default port is "502"')
		print('enter "d" for default or enter formated line as "ip@port" with no space')
		print('example: "192.168.2.2@502", no quotation marks')
		sleep(0.2)
		inp = input('ip@port: ')
		if inp == 'd':
			ip_addr, port = '192.168.2.88', '502'
		else:
			ip_addr, port = inp.split('@')

		print('\nstep: 2/5')
		print('sample interval')
		print('unit is second, default value is 0.5sec')
		print('enter d for devault or a number')
		print('example: "60" for 1min sample rate, 0.01 for 10ms sample rate')
		sleep(0.2)
		inp = input('sample interval: ')
		if inp=='d':
			interval = 0.5
		else:
			interval = inp

		print('\nstep: 3/5')
		print('registers arrangement')
		print('use "," to separate, ":" to split register & number')
		print('example: "6001:4,6081:2,6085:2" means 6001~6004, 6081~6082, 6085~6086')
		print('attention: float takes 2 regs')
		sleep(0.2)
		inp = input('regs: ')
		regs = inp

		print('\nstep: 4/5')
		print('colums of all parameters names')
		print('space as separate')
		print('example: "ch1_CO,ch2_CO2,ch3_NO,ch4_SO2,Temp-1"')
		sleep(0.2)
		inp = input('columns: ')
		columns = inp

		print('\nstep: 5/5')
		sleep(0.2)
		inp = input('explaination & comment: ')
		expl = datetime.now().ctime() + ',\t' + inp

		ds = {'ip_addr':ip_addr, 'port':port, 'interval':interval, 'regs':regs, 'columns': columns, 'expl': expl}
		print('please check data')
		print(ds)
		sleep(0.2)
		inp = input('"y" for ok, "q" for quit, others for retry:\n')
		if inp == "y":
			break
		elif inp == "q":
			print('all config abandonded')
			return
		else:
			pass

	cfg_df = cfg_df.append(ds, ignore_index=True)
	dumpc('config.cdt', cfg_df)

