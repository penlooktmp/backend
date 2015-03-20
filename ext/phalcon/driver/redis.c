/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Tin Nguyen       <tinntt@penlook.com>
 *     Thanh Huynh      <thanhhb@penlook.com>
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "php_ext.h"
#include "hiredis/hiredis.h"
#include "zend_exceptions.h"
#include <stdlib.h>

#define REDIS_RESOURCE   "REDIS RESOURCE"
#define REDIS_MODULE_ID  12345

// List entities of redis
int le_redis;

/**
 * Establish new redis connection
 *
 * @param {zval}  *return_value Result handler
 * @param {char*} *host         Ip address
 * @param {char*} *port         Port number
 */
void redis_connect(zval *return_value, char* *host, int *port) {

	// Establish redis connection
	redisContext *context = redisConnect(*host, *port);

	if (context != NULL && context->err) {

		// Can not establish connection to redis
    	zend_throw_exception(zend_exception_get_default(TSRMLS_C), "Connection was refused !", 10001 TSRMLS_CC);
    	RETURN_FALSE;

	} else {

		// Create new PHP resource based on redis context information
		le_redis = zend_register_list_destructors_ex(NULL, NULL, REDIS_RESOURCE, REDIS_MODULE_ID);
		ZEND_REGISTER_RESOURCE(return_value, context, le_redis);
	}
}

/**
 * Parse context from PHP Redis resource
 *
 * @param {zval} *return_value Result handler
 * @param {zval} *redis Redis connection
 */
redisContext *parse_context(zval *return_value, zval *redis) {

	// Redis context - connection information
	redisContext *context;

	// Decode resource to redisContext
	ZEND_FETCH_RESOURCE(context, redisContext*, &redis, -1, REDIS_RESOURCE, le_redis);

	// Verify context
	ZEND_VERIFY_RESOURCE(context);

	return context;
}

/**
 * Return redis result
 *
 * @param {zval} return_value Result handler
 * @param {redisReply} *reply Redis reply from execution
 */
void return_result(zval *return_value, redisReply *reply) {
	if (reply == NULL) {
		// Redis error
		RETURN_FALSE;
	} else {
		ZVAL_STRINGL(return_value, reply->str, reply->len, 1);
	}
}

/**
 * Redis SET
 *
 * @param {zval}  *return_value Result handler
 * @param {zval}  *redis        Redis context
 * @param {char*} *key		    Key
 * @param {char*} *value        Value
 */
void redis_set(zval *return_value, zval *redis, char* *key, char* *value) {

	redisContext *context = parse_context(return_value, redis);

	// Execute redis command identified by context
	redisReply *reply = redisCommand(context, "SET %s %s", *key, *value);
	return_result(return_value, reply);
}

/**
 * Redis GET
 *
 * @param {zval}  *return_value Result handler
 * @param {zval}  *redis        Redis context
 * @param {char*} *key          Key
 */
void redis_get(zval *return_value, zval *redis, char* *key) {

	redisContext *context = parse_context(return_value, redis);

	// Execute redis command identified by context
	redisReply *reply = redisCommand(context, "GET %s", *key);
	return_result(return_value, reply);
}