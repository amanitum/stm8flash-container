#### 1.Build the image:
`docker build -t stm8flash:latest .`

#### 2.Make sure the image is built:
`docker images`

#### 3.Run the container:
\```
docker run --rm -it \
  --device=/dev/bus/usb \
  --user root \
  -v $(pwd):/work -w /work \
  stm8flash:latest \
  -c stlinkv2 -p stm8s103?3 -r dump
\```
