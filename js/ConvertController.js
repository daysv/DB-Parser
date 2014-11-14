function ConvertController()
{
}

ConvertController.BDToSimple = function (chart)
{
	var parser = new BDParser();
	parser.parseChart(chart);
	var tokens = parser.getTokenList();
	var result = '';
	var tmpToken;
	var tmpLength = tokens.length;
	for (var i = 0; i < tmpLength ; i++)
	{
		if (tokens[i] instanceof BDToken)
		{
			tmpToken = tokens[i].toNumberToken();
			result += (tmpToken == null? '' : String(tmpToken));
		}
		else if (tokens[i] instanceof OtherToken)
		{
			result += tokens[i].toString();
		}
	}
	return result;
}

ConvertController.SimpleToBD = function (chart)
{
	var parser = new Parser();
	parser.parseChart(chart);
	var tokens = parser.getTokenList();
	var result = '';
	var tmpToken;
	var tmpLength = tokens.length;
	
	for (var i = 0; i < tmpLength ; i++)
	{
		if (tokens[i] instanceof NumberToken)
		{
			tmpToken = tokens[i].toBDToken();
			result += (tmpToken == null? '' : String(tmpToken));
		}
		else if (tokens[i] instanceof OtherToken)
		{
			result += tokens[i].toString();
		}
	}
	return result;
}


ConvertController.OtherReverse = function (chart)
{
	NumberToken.otherSymbol = !NumberToken.otherSymbol;
	var parser = new Parser();
	parser.parseChart(chart);
	var tokens = parser.getTokenList();
	var result = '';
	var tmpToken;
	var tmpLength = tokens.length;

	for (var i = 0; i < tmpLength ; i++)
	{
		result += tokens[i].toString();
	}
	
	return result;
}

ConvertController.SimpleUpperCase = function (chart)
{
	var parser = new Parser();
	parser.parseChart(chart);
	var tokens = parser.getTokenList();
	var result = '';
	var tmpToken;
	var tmpLength = tokens.length;
	
	for (var i = 0; i < tmpLength ; i++)
	{
		if (tokens[i] instanceof NumberToken)
		{
			tmpToken = tokens[i].toUp();
			result += (tmpToken == null? '' : String(tmpToken));
		}
		else if (tokens[i] instanceof OtherToken)
		{
			result += tokens[i].toString();
		}
	}
	return result;
}

ConvertController.SimpleLowerCase = function (chart)
{
	var parser = new Parser();
	parser.parseChart(chart);
	var tokens = parser.getTokenList();
	var result = '';
	var tmpToken;
	var tmpLength = tokens.length;
	
	for (var i = 0; i < tmpLength ; i++)
	{
		if (tokens[i] instanceof NumberToken)
		{
			tmpToken = tokens[i].toLower();
			result += (tmpToken == null? '' : String(tmpToken));
		}
		else if (tokens[i] instanceof OtherToken)
		{
			result += tokens[i].toString();
		}
	}
	return result;
}


ConvertController.SimpleReverse = function (chart)
{
	var parser = new Parser();
	parser.parseChart(chart);
	var tokens = parser.getTokenList();
	var result = '';
	var tmpLength = tokens.length;

	for (var i = 0; i < tmpLength ; i++)
	{
		if (tokens[i] instanceof NumberToken)
		{
			result += tokens[i].toReverseString();
		}
		else if (tokens[i] instanceof OtherToken)
		{
			result += tokens[i].toString();
		}
	}
	return result;
}

