package org.uniovi.miw.jgen.generator.model

import org.eclipse.xtend.lib.annotations.Data

@Data class JGenExpressionObject {
	String type;
	boolean isLogical;
	JGenExpressionObject first;
	JGenExpressionObject second;
	String text;
}