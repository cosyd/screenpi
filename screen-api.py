#
#       screen-api.py
#
#       Simon Rehbach April/May 2019
#
#       runs omxplayer video stream on a waveshare display with cropped dimensions to fit gira frame
#       uses flask to create a simple API to start / stop the screen
#

#
# To run as server for API: add this to your rc.local
#   export FLASK_APP=/home/pi/screen-api/screen-api.py
#   python3 -m flask run --host 0.0.0.0 &
# the webhook can then be called with eg. screenpi_ip:5000/screen/on, off, timer?duration=120
#

from flask import Flask
from flask import Response
from flask import request
import subprocess
import time
import sys
sys.path.append("/home/pi/screenpi") # configure different path here if needed
import screen-api-conf

app = Flask (__name__)
def shellcall(callstring):
        call=callstring.split(' ') # explode shell call string for subprocess (needs single args)
        return subprocess.Popen(call, stdin=subprocess.PIPE, stdout=None, stderr=None, bufsize=0)


@app.route("/screen/timer", methods=["GET", "POST"])
def screen_timer():
        global omx_start
        global omx_kill
        try:
                duration=int(request.values['duration'])
                omxproc=shellcall(omx_start)
				Response('200 OK (Started '+omx_start+' for '+str(duration)+'s)', status=200, mimetype='text/plain')
                time.sleep(duration)
                omxproc=shellcall(omx_kill)
                return 
        except Exception:
                return Response('400 Error (Failed '+omx_start+', call error or invalid parameter)', status=400, mimetype='text/plain')
				
@app.route("/screen/on", methods=["GET", "POST"])
def screen_on():
        global omx_start
        try:
                omxproc=shellcall(omx_start)
                return Response('200 OK (Started '+omx_start+')', status=200, mimetype='text/plain')
        except Exception:
                return Response('400 Error (Failed '+omx_start+')', status=400, mimetype='text/plain')



@app.route("/screen/off", methods=["GET", "POST", "DELETE"])
def screen_off():
        try:
                global omxproc
                global omx_kill
                shellcall(omx_kill)
                return Response('200 OK (Screen off - '+omx_kill+')', status=200, mimetype='text/plain')
        except Exception:
                return Response('400 Error (Could not terminate omxplayer - '+omx_kill+')', status=400, mimetype='text/plain')

if __name__ ==  '__main__':
        app.run(debug=True)
