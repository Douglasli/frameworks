mylocal="$HOME/local" 
cd ${mylocal}
# install supporting mpir library
tar -xvf mpir-3.0.0.tar.bz2
rm mpir-3.0.0.tar.bz2
cd mpir-3.0.0
./configure --enable-cxx --prefix="${mylocal}/mpir"
make && make check && make install

# install OpenSSL 1.1.1 
cd $mylocal 
tar -xf openssl-1.1.1j.tar.gz 
rm openssl-1.1.1j.tar.gz  
cd openssl-1.1.1j
./config --prefix="${mylocal}/openssl"

make && make install

# install crypto++ 
cd $mylocal 
unzip cryptopp820.zip -d cryptopp820 
rm cryptopp820.zip 
cd cryptopp820 
make && make install PREFIX=${mylocal}/cryptopp

cd
echo 'export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.bash_profile
curl https://sh.rustup.rs -sSf | sh -s -- -y
