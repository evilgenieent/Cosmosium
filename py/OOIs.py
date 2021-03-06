import pickle
import json

OOI_FILE = 'db/OOIs.pickle'

class OOIs(object):
    # objects of interest list class to handle saving/loading
    def __init__(self):
        self.MPOs  = list() #list of all OoIs
        self.owners= list() #matched list of user ids for each OoI
        try: 
            self._readOOIs()
            print str(len(self))+' OOIs unpickled.'
        except IOError:
            print 'pickled OOIs not loaded.'
        
    def __len__(self):
        return len(self.MPOs)
        
    def _saveOOIs(self):
        with open(OOI_FILE, 'wb') as f:
            pickle.dump(self, f)
            print str(len(self))+' OOIs pickled.'


    def _readOOIs(self):
        try:
            with open(OOI_FILE, 'rb') as f:
                self = pickle.load(f)
        except EOFError:    
            print 'WARN: OOI.pickle is empty! Starting from scratch.'
            
    def addObject(self,obj,ownerName=None):
        if ownerName!=None:
            self.owners.append(ownerName)
        self.MPOs.append(obj)
        print 'MPO added.'
        
    #with open(OOI_JSON_FILE,'r') as f:
    #    OOIs = json.loads(f.read().split('=')[1])
    def write2JSON(self,OOIfile,OwnerFile):
        self.__OOI2JSON(OOIfile)
        self.__owners2JSON(OwnerFile)
        
    def __owners2JSON(self,fName):
        with open(fName,'w') as f:
            if len(self.owners) > 0:
                dat = '['
                for owner in self.owners:
                    dat+='"'+str(owner)+'"'
                    dat+=','
                dat = dat[:-1] # slice off last comma
                dat+='];\n'
            else :
                dat = "[]"
            f.write('var owners = '+dat)

    def __OOI2JSON(self,fName):
        with open(fName,'w') as f:
            if len(self.MPOs) > 0:
                dat = '['
                for mpo in self.MPOs:
                    dat+=json.dumps(mpo).decode("string-escape")[2:-2]
                    dat+=','
                dat = dat[:-1] # slice off last comma
                dat+='];\n'
            #    dat = json.dumps(self.MPOs).decode("string-escape")
            #    for i in range(len(dat)):
            #        print 'dat['+str(i)+']=',dat[i]
            #        dat[i] = dat[i][2:-2]
            else :
                dat = "[]"
            f.write('var TestAsteroids = '+dat)