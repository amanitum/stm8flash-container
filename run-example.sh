docker run --rm -it \
  --device=/dev/bus/usb \
  --user root \
  -v $(pwd):/work -w /work \
  stm8flash:latest \
 # -c stlinkv2 -p stm8s103?3 -r dump
  stm8flash --version
