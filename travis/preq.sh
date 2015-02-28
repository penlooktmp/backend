#! /bin/sh

DIR=$(readlink -enq $(dirname $0))

echo $DIR

sudo apt-get -qq update &

if [ "$(php -r 'echo PHP_VERSION_ID;')" -ge 50500 ]; then
	( pecl install apcu < /dev/null || ( pecl config-set preferred_state beta; pecl install channel://pecl.php.net/apcu-4.0.7 < /dev/null ) && phpenv config-add "$DIR/apcu.ini" ) &
else
	( CFLAGS="-O2 -g3 -fno-strict-aliasing" pecl upgrade apc < /dev/null; phpenv config-add "$DIR/apc.ini" ) &
fi

CFLAGS="-O1 -g3 -fno-strict-aliasing" pecl install yaml < /dev/null &
CFLAGS="-O1 -g3 -fno-strict-aliasing" pecl install mongo < /dev/null &
( pecl install channel://pecl.php.net/weakref-0.2.6 < /dev/null || ( pecl config-set preferred_state beta; pecl install weakref < /dev/null ) ) &

wait
phpenv config-add "$DIR/memcache.ini"
phpenv config-add "$DIR/memcached.ini"
phpenv config-add "$DIR/mongo.ini"
phpenv config-add "$DIR/redis.ini"
phpenv config-rm xdebug.ini