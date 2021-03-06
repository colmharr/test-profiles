#!/bin/sh

tar -xjf ffmpeg-1.1.tar.bz2
mkdir ffmpeg_/

cd ffmpeg-1.1/
./configure --disable-zlib --prefix=$HOME/ffmpeg_/
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
make install
cd ~/
rm -rf ffmpeg-1.1/
rm -rf ffmpeg_/lib/

echo "#!/bin/sh

./ffmpeg_/bin/ffmpeg -i HD2-h264.ts -f rawvideo -threads \$NUM_CPU_CORES -y -target ntsc-dv /dev/null 2>&1
echo \$? > ~/test-exit-status" > ffmpeg
chmod +x ffmpeg
