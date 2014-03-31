class MatlabWrapper(object):
def __init__(self, barrier_fullname=DEFAULT_BARRIER_FULLNAME):
self.barrier_fullname = barrier_fullname
 
def run(self):
self.process = subprocess.Popen(
'matlab -nodisplay -nosplash', shell=True,
stdin=subprocess.PIPE, stdout=DEVNULL, stderr=DEVNULL)
 
self.process.stdin.write('matlabpool 8;\n')
self.process.stdin.flush()
 
def execute(self, cmd):
try:
os.remove(self.barrier_fullname)
except:
pass
 
self.process.stdin.write(cmd);
self.process.stdin.write('!touch %s\n' % self.barrier_fullname);
self.process.stdin.flush()
 
while True:
try:
with open(self.barrier_fullname, 'rb') as _:
break
except IOError:
time.sleep(1)
 
os.remove(self.barrier_fullname)
 
def exit(self):
self.process.stdin.write('exit;\n')
self.process.stdin.flush()
self.process.wait()
 
self.process = None
