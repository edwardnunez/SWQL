package org.uniovi.miw.jgen.valueconverters

import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.nodemodel.INode
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter

class USERValueConverter extends AbstractLexerBasedConverter<String> {
	
	override toValue(String string, INode node) throws ValueConverterException {
		if(string.charAt(1) === '"'.charAt(0) || string.charAt(1) === "'".charAt(0))
			return string.substring(2, string.length-1);
		return string.substring(1);
	}
}