THREADS=$(nproc)

mkdir work-apache2-inst
cd work-apache2-inst
mkdir plugin
cd plugin
if [ -f /etc/debian_version ]; then
    apt update
    apt install autoconf re2c bison libsqlite3-dev libpq-dev libonig-dev libfcgi-dev libfcgi0ldbl libjpeg-dev libpng-dev libssl-dev libxml2-dev libcurl4-openssl-dev libxpm-dev libgd-dev libmysqlclient-dev libfreetype6-dev libxslt1-dev libpspell-dev libzip-dev libgccjit-10-dev -y
elif [ -f /etc/redhat-release ]; then
    yum install git make gcc gcc-c++ binutils glibc-devel autoconf libtool bison re2c automake libxml2-devel openssl-devel libcurl-devel libjpeg-devel libpng-devel libXpm-devel freetype-devel libicu-devel libxslt-devel libzip-devel libgccjit-devel sqlite-devel oniguruma-devel postgresql-devel -y
else 
    echo "Unsupported OS"
    exit 1
fi

curl -L https://www.php.net/distributions/php-8.2.4.tar.gz | tar xz
./configure --with-apxs2=/usr/local/apache2/bin/apxs --enable-cli --enable-fpm --enable-intl --enable-mbstring --enable-opcache --enable-sockets --enable-soap --with-curl --with-freetype --with-fpm-user=www-data --with-fpm-group=www-data --with-jpeg --with-mysql-sock --with-mysqli --with-openssl --with-pdo-mysql --with-pgsql --with-xsl --with-zlib
make -j $THREADS && make install -j $THREADS
cd ../../../
