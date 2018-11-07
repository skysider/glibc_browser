OUTPUT_DIRECTORY=/root/public_html/glibc
DATA_DIRECTORY=$OUTPUT_DIRECTORY/../data
BUILD_DIRECTORY=$PWD
SOURCE_DIRECTORY=$PWD
codebrowser_generator -b $BUILD_DIRECTORY -a -o $OUTPUT_DIRECTORY -p glibc:$SOURCE_DIRECTORY
codebrowser_indexgenerator $OUTPUT_DIRECTORY
cp -rv /root/woboq_codebrowser/data $DATA_DIRECTORY
