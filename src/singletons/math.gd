extends Node


func logn(num : float, base : float) -> float:
	return log(num)/log(base);

func safe_div(num1 : float, num2 : float, return_inf : bool = true) -> float:
	return (INF if return_inf else 0.0) if num1 == 0.0 || num2 == 0.0 else num1/num2;
