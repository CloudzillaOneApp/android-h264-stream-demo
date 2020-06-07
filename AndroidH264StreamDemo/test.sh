# Install gstreamer
# on Mac this is the command line;
# brew install gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav

# Start gstreamer on local machine
/gst-launch-1.0 udpsrc port=50000 ! video/x-h264,width=640,height=480,framerate=30/1,stream-format=avc ! queue ! avdec_h264 ! queue ! autovideosink


# Need to find the local IP address to provide to the app
# ifconfig 
# Input the Host IP and udp port gstreamer is listening on (50000) into the app.
