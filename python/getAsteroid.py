
import requests
from bottle import route, run, request, template
import json

def asterankAPI(query, limit):
    # queries the asterank API as guided by http://www.asterank.com/mpc
    # query = (regex?) specifier string
    # limit = max asteroids to return
    payload = {'query':str(query),'limit':str(limit)}
    print 'payload:',payload
    r = requests.get("http://asterank.com/api/asterank", params=payload)
    # r = requests.get("http://asterank.com/api/asterank?query="+query+"&limit="+str(limit))
    resp = str(r.json())
    print('json='+resp)
#    print('text='+r.text)
    return resp
    
@route('/addAsteroid')
def addOOI():
    name = request.query.name
    OOIs.append(byName(name))
    print 'object '+name+' added to OOIs'
    print OOIs

@route('/getAsteroids')
def getOOIs():
    return json.dumps(OOIs)
    
@route('/asteroidReq')
def processReq():
    q = request.query.query
    lim = request.query.limit
    print 'q=',q,' l=',lim
    return template('type: {{datatype}} (response {{res}})', datatype="asterank", res=asterankAPI(q,lim))

def byName(name):
    q = '{"full_name":'+name+'}'
    return asterankAPI(q,1)

if __name__ == "__main__":
#    resp = asterankAPI('{"e":{"$lt":0.1},"i":{"$lt":4},"a":{"$lt":1.5}}', 2)
#    print resp
    OOIs = list()
    run(host='localhost', port=8080, debug=True)
