package org.uniovi.miw.jgen.valueconverters

import com.google.inject.Inject
import org.eclipse.xtext.common.services.DefaultTerminalConverters
import org.eclipse.xtext.conversion.ValueConverter
import org.eclipse.xtext.conversion.IValueConverter

class CustomValueConverter extends DefaultTerminalConverters {
	@Inject
    EXACTLYValueConverter exactlyValueConverter
        
    @ValueConverter(rule = "EXACTLY")
    def IValueConverter<String> EXACTLY() {
    	return exactlyValueConverter;
    }
    
    @Inject
    DOUBLEValueConverter doubleValueConverter
        
    @ValueConverter(rule = "DOUBLE")
    def IValueConverter<Double> DOUBLE() {
    	return doubleValueConverter;
    }
    
    @Inject
    USERValueConverter userValueConverter
        
    @ValueConverter(rule = "USER")
    def IValueConverter<String> USER() {
    	return userValueConverter;
    }
    
    @Inject
    KEYWORDValueConverter keywordValueConverter
        
    @ValueConverter(rule = "KEYWORD")
    def IValueConverter<String> KEYWORD() {
    	return keywordValueConverter;
    }
}