# this goes at the end of your $HOME/.bashrc file

export mylocal="$HOME/local"

# export OpenSSL paths

export PATH="${mylocal}/openssl/bin/:${PATH}"

export C_INCLUDE_PATH="${mylocal}/openssl/include/:${C_INCLUDE_PATH}"

export CPLUS_INCLUDE_PATH="${mylocal}/openssl/include/:${CPLUS_INCLUDE_PATH}"

export LIBRARY_PATH="${mylocal}/openssl/lib/:${LIBRARY_PATH}"

export LD_LIBRARY_PATH="${mylocal}/openssl/lib/:${LD_LIBRARY_PATH}"

# export MPIR paths

export PATH="${mylocal}/mpir/bin/:${PATH}"

export C_INCLUDE_PATH="${mylocal}/mpir/include/:${C_INCLUDE_PATH}"

export CPLUS_INCLUDE_PATH="${mylocal}/mpir/include/:${CPLUS_INCLUDE_PATH}"

export LIBRARY_PATH="${mylocal}/mpir/lib/:${LIBRARY_PATH}"

export LD_LIBRARY_PATH="${mylocal}/mpir/lib/:${LD_LIBRARY_PATH}"

# export Crypto++ paths

export CPLUS_INCLUDE_PATH="${mylocal}/cryptopp/include/:${CPLUS_INCLUDE_PATH}"

export LIBRARY_PATH="${mylocal}/cryptopp/lib/:${LIBRARY_PATH}"

export LD_LIBRARY_PATH="${mylocal}/cryptopp/lib/:${LD_LIBRARY_PATH}"

# download SCALE-MAMBA v1.11
cd 
git clone https://github.com/KULeuven-COSIC/SCALE-MAMBA.git
cd SCALE-MAMBA
git checkout -b v1.11 8123e690f622a79f6ed1199fe1be7db3cd23699a
# cp /root/source/CONFIG.mine .
cd $HOME/SCALE-MAMBA 
cp CONFIG CONFIG.mine 
echo "ROOT = $HOME/SCALE-MAMBA" >> CONFIG.mine 
echo "OSSL = /root/local/openssl" >> CONFIG.mine
make progs

# set up certificate authority
touch ~/.rnd # see: https://github.com/openssl/openssl/issues/7754
SUBJ="/CN=www.example.com"
cd Cert-Store

openssl genrsa -out RootCA.key 4096
openssl req -new -x509 -days 1826 -key RootCA.key \
           -subj $SUBJ -out RootCA.crt

# make 4 certificates. More can be added as necessary
mkdir csr
for ID in {0..3}
do
  SUBJ="/CN=player$ID@example.com"
  openssl genrsa -out Player$ID.key 2048
  openssl req -new -key Player$ID.key -subj $SUBJ -out csr/Player$ID.csr
  openssl x509 -req -days 1000 -set_serial 101$ID \
    -CA RootCA.crt -CAkey RootCA.key \
    -in csr/Player$ID.csr -out Player$ID.crt 
done

# copy examples to correct locations
cd /root/SCALE-MAMBA
for EX in mult3 innerprod xtabs linear_regression
do
  mkdir Programs/$EX
  cp /root/source/$EX.mpc Programs/$EX/
done

# add simple syntax highlighting
cd
mkdir -p .vim/syntax
mv source/mamba.vim .vim/syntax
mkdir .vim/ftdetect
echo "au BufNewFile,BufRead *.mpc set filetype=mamba" > .vim/ftdetect/mamba.vim
