#!/usr/bin/python

# Parsing del .json e creazione dei comandi sqlite3 per inserire in BB
#
# File : Json da http://www.cutandpasta.it/
# file XML formato XMLTV - http://webgrabplus.com/epg-channels
#

import sys
import getopt
import datetime
import sqlite3

import json
from pprint import pprint
from unidecode import unidecode

xml_types = (
    'ALTRI EVENTI SPORTIVI',
    'ANIMAZIONI',
    'Approfondimento',
    'ATTUALITA\'',
    'AVVENTURA',
    'AZIONE',
    'BIOGRAFICO',
    'Cartone animato',
    'CARTOON',
    'COMICO',
    'COMMEDIA',
    'CONCERTO',
    'Cucina e Sapori',
    'Cultura',
    'DIBATTITO',
    'DI MONTAGGIO',
    'DIVULGAZIONE SCIENTIFICO/CULTURALE',
    'DOCU-FICTION',
    'DOCUMENTARI',
    'Documentario',
    'DOCUMENTARISTICO',
    'DOCU-SOAP',
    'DOCUTAINMENT',
    'DRAMMATICO',
    'FANTASCIENZA',
    'FANTASTICO/FAVOLISTICO',
    'Fiction',
    'Film',
    'FILM',
    'FILM TV',
    'FUNZIONE RELIGIOSA',
    'Game show',
    'GAME SHOW/QUIZ',
    'GIALLO',
    'GUERRA',
    'HORROR',
    'Intrattenimento',
    'INTRATTENIMENTO',
    'MANIFESTAZIONE SPORTIVA',
    'Mondo e tendenze',
    'Musica',
    'NATURA/AMBIENTE/ETNOLOGIA',
    'News',
    'NOVELAS',
    'POLIZIESCO',
    'PROGRAMMA DI SERVIZIO',
    'PROGRAMMA MUSICALE',
    'PROGRAMMI CULTURALI',
    'PROGRAMMI RELIGIOSI',
    'REALITY',
    'REAL TV',
    'Religione',
    'RIASSUNTO TELENOVELAS',
    'ROTOCALCO',
    'RUBRICA ATTUALITA\' SPORTIVA',
    'RUBRICA AUTOPROMOZIONALE',
    'RUBRICA DI ATTUALITA\'',
    'RUBRICA DI SERVIZIO',
    'Salute',
    'SENTIMENTALE',
    'SERIE',
    'Serie',
    'serie',
    'SHOPPING',
    'Sit-com',
    'SITCOM',
    'SOAP',
    'Soap opera',
    'SPIONAGGIO',
    'Sport',
    'SPORT',
    'STORICO',
    'Talk show',
    'TALK SHOW',
    'Telefilm',
    'Telenovela',
    'TELEGIORNALE',
    'TELEGIORNALE SPORTIVO',
    'TELEGIORNALI',
    'THRILLER',
    'TURISMO/GEOGRAFIA/ETNOLOGIA',
    'VARIETA\'',
    'WESTERN',
)

bbox_types = (
    'Sport',
    'Cartone animato',
    'Approfondimento',
    'News',
    'Fiction',
    'Fiction',
    None,
    'Cartone animato',
    'Cartone animato',
    None,
    None,
    'Musica',
    'Cucina e Sapori',
    'Cultura',
    None,
    None,
    None,
    'Documentario',
    'Documentario',
    'Documentario',
    'Documentario',
    'Documentario',
    'Documentario',
    'Fiction',
    'Fiction',
    'Fiction',
    'Fiction',
    'Film',
    'Film',
    'Film',
    'Religione',
    'Game show',
    'Game show',
    None,
    None,
    None,
    'Intrattenimento',
    'Intrattenimento',
    'Sport',
    'Mondo e tendenze',
    'Musica',
    None,
    'News',
    'Soap opera',
    'Fiction',
    None,
    'Musica',
    'Cultura',
    'Religione',
    None,
    None,
    'Musica',
    None,
    None,
    'Sport',
    None,
    'News',
    None,
    'Salute',
    None,
    None,
    None,
    None,
    'Televendita',
    'Sit-com',
    'Sit-com',
    'Soap opera',
    'Fiction',
    'Sport',
    'Sport',
    None,
    'Talk show',
    'Talk show',
    'Telefilm',
    'Soap opera'
    'News',
    'News',
    'News',
    'Fiction',
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
    None,
)



infil = sys.argv[1]

with open(infil) as data_file:
    js = json.load(data_file)

conn = sqlite3.connect('epg.v2.sqlite.db')
c = conn.cursor()

##pprint(js)
#print js["tv"]['@generator-info-name']
#print js["tv"]['@generator-info-url']
#print js["tv"]["channel"][0]

#print js["tv"]["programme"][0]

id = 100001

c.execute('DELETE from show')

for show in js["tv"]["programme"]:
    #print show["@channel"]
    ch = show["@channel"]
    p = ( ch, )
    c.execute('SELECT id FROM channel WHERE name LIKE ?', p )
    sch = c.fetchone()
    if sch:
        ch = sch[0]
    else:
        continue

    s = show["@start"]
    ts_s = int(datetime.datetime.strptime(s.split(' ')[0], '%Y%m%d%H%M%S').strftime("%s"))
    e = show["@stop"]
    ts_e = int(datetime.datetime.strptime(e.split(' ')[0], '%Y%m%d%H%M%S').strftime("%s"))
##    ts_e = int(datetime.datetime.strptime(e, '%Y%m%d%H%M%S +0200').strftime("%s"))
##    print ts_s, ts_e, (ts_e-ts_s)/60
    ts_s = ts_s / 60
    ts_e = ts_e / 60
    td = ts_e-ts_s

    stit = show.get("title")
    if stit:
#        print stit
        if isinstance(stit,list):
            tit = stit[0].get("#text")
        else:
            tit = stit.get("#text")
    else:
        tit = 'Titolo Non Disponibile'
#    print tit

    sdes = show.get("desc")
    if sdes:
        des = sdes["#text"]
    else:
        des = None

    sdate = show.get("date")
    if sdate:
        year = sdate["#text"]
    else:
        year = None

    scat = show.get("category")
    if scat:
        # print scat
        if isinstance(scat,list):
            cat = scat[0].get("#text")
        else:
            cat = scat.get("#text")
	cat=cat.split('<')[0]
#        print cat
        bbcat = bbox_types[xml_types.index(cat)]
        p = ( bbcat, )
        c.execute('SELECT id FROM type WHERE it LIKE ?', p )
        row = c.fetchone()
        #~ print bbcat, row
        if row:
            typ = row[0]
            #~ print typ
        else:
            typ = None
    else:
        typ = None

    p = ( id,ch,ts_e,tit,td,des,typ,year )
    #~ print p
    c.execute('INSERT INTO show(id,channel,end_date,title,duration,description,type,year) VALUES(?,?,?,?,?,?,?,?)', p )

    #~ print id
    id = id + 1

print "Inseriti ", id - 100001, "Programmi"
c.execute('UPDATE show SET is_premiere=0, is_hd=0, is_premium=0, is_live=0, is_lis=0, is_subtitled=0 ;')

conn.commit()
conn.close()


# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
