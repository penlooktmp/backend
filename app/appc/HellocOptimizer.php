<?php
namespace Zephir\Optimizers\FunctionCall;

use Zephir\Call;
use Zephir\CompilerException;
use Zephir\CompilationContext;
use Zephir\Optimizers\OptimizerAbstract;

class HellocOptimizer extends OptimizerAbstract
{
	public function optimize(array $expression, Call $call, CompilationContext $context)
	{
		$call->processExpectedReturn($context);
        $symbolVariable = $call->getSymbolVariable();
        $args = $call->getReadOnlyResolvedParams($expression['parameters'], $context, $expression);
        return new CompiledExpression('int', 'helloc(' . $args[0] . ')', $expression);
	}
}
