package org.uniovi.miw.jgen.valueconverters

import org.eclipse.xtext.nodemodel.INode
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractValueConverter

class DOUBLEValueConverter extends AbstractValueConverter<Double> {
	
	override Double toValue(String string, INode node) throws ValueConverterException {
		// to make this more robust
		return Double.parseDouble(string) 
	}
	override String toString(Double value) throws ValueConverterException {
		// to make this more robust
		return Double.toString(value) 
	}
}