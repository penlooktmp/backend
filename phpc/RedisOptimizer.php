<?php
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
 *     Nam Vo           <namvh@penlook.com>
 */

namespace Zephir\Optimizers\FunctionCall;

use Zephir\Call;
use Zephir\CompilationContext;
use Zephir\CompilerException;
use Zephir\CompiledExpression;
use Zephir\Optimizers\OptimizerAbstract;
use Zephir\HeadersManager;

/**
 * Redis Optimizer
 *
 * @category   Penlook Application
 * @package    Optimizer\Redis
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class RedisOptimizer extends OptimizerAbstract
{
	public function getParams($expression)
	{
		$params = [];
		$mixs = $expression['parameters'];

		foreach ($mixs as $arg) {
			$params[] = $arg["parameter"]["value"];
		}

		return $params;
	}

	/**
	 *
	 * @param array $expression
	 * @param Call $call
	 * @param CompilationContext $context
	 */
	public function optimize(array $expression, Call $call, CompilationContext $context)
	{
        $call->processExpectedReturn($context);
      	$args = $this->getParams($expression);
        $func = strtolower($args[0]);

        $call->processExpectedReturn($context);

		$symbolVariable = $call->getSymbolVariable();
		if ($symbolVariable->getType() != 'variable') {
			throw new CompilerException("Returned values by functions can only be assigned to variant variables", $expression);
		}

		if ($call->mustInitSymbolVariable()) {
			$symbolVariable->initVariant($context);
		}

        $args = $call->getReadOnlyResolvedParams($expression['parameters'], $context, $expression);

        switch ($func) {
        	case 'connect':
        		$other_arguments = $args[1] . ','. $args[2];
        		break;

        	default:
        		$args_len = count($args);
        		$other_arguments = "";

        		for ($i = 1; $i < $args_len; $i++) {
        			$other_arguments .= $args[$i] . ',';
        		}

        		$other_arguments = substr($other_arguments, 0, count($other_arguments) - 2);
        		break;
        }

        $cmd = 'redis_' . $func .'('. $symbolVariable->getName(). ',' . $other_arguments . ');';
        $context->codePrinter->output($cmd);
        return new CompiledExpression('variable', $symbolVariable->getRealName(), $expression);
	}

}