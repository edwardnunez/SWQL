package org.uniovi.miw.jgen.generator.model

import org.eclipse.xtend.lib.annotations.Data

@Data class JGenQueryObject {
	String type;
	String id;
	JGenExpressionObject expression;
}