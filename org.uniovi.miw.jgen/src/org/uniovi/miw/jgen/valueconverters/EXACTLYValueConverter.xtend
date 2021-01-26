package org.uniovi.miw.jgen.valueconverters

import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter
import org.eclipse.xtext.nodemodel.INode
import org.eclipse.xtext.conversion.ValueConverterException

class EXACTLYValueConverter extends AbstractLexerBasedConverter<String> {
	
	override toValue(String string, INode node) throws ValueConverterException {
		return string.substring(2, string.length-2)
	}
}