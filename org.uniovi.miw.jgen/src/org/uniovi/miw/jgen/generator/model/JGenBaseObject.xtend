package org.uniovi.miw.jgen.generator.model

import org.eclipse.xtend.lib.annotations.Data
import java.util.List

@Data class JGenBaseObject {
	int queryNumber;
	List<JGenQueryObject> queries;
	List<String> platforms;
	JGenLocationObject location;
	JGenDateObject dates;
	String searchMode;
	String lang;
	Integer maxResults;
	Integer interval;
	Integer endIn;
	Integer delay;
}