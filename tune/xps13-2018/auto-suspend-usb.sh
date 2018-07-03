echo "finger print reader"
sudo sh -c "echo 'auto' > '/sys/bus/usb/devices/1-10/power/control'"

echo "web camera"
sudo sh -c "echo 'auto' > '/sys/bus/usb/devices/1-5/power/control'"

echo "Audio codec power management"
sudo sh -c "echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';"
