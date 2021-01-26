package org.uniovi.miw.jgen.interpreter

import com.google.common.base.Strings
import org.uniovi.miw.jgen.jGen.AndExpression
import org.uniovi.miw.jgen.jGen.ExactlySearch
import org.uniovi.miw.jgen.jGen.KeywordSearch
import org.uniovi.miw.jgen.jGen.Model
import org.uniovi.miw.jgen.jGen.NotExpression
import org.uniovi.miw.jgen.jGen.OrExpression
import org.uniovi.miw.jgen.jGen.QueryExpression
import org.uniovi.miw.jgen.jGen.SimpleSearch
import org.uniovi.miw.jgen.jGen.UserSearch
import org.uniovi.miw.jgen.jGen.SimpleQuery
import org.uniovi.miw.jgen.jGen.BioQuery
import org.uniovi.miw.jgen.jGen.PostQuery
import org.uniovi.miw.jgen.jGen.CommentsQuery
import org.uniovi.miw.jgen.jGen.AllSearch
import org.uniovi.miw.jgen.jGen.ResponseQuery

class JGenInterpreter {
	
	private def void interpretQueryExprOutline(QueryExpression exp, int level, StringBuilder sb) {
		switch(exp) {
			AndExpression: {
				sb.append('''«Strings.repeat("\t",level)»And
«Strings.repeat("\t",level)»{
				''')
				interpretQueryExprOutline(exp.left, level + 1, sb)
				interpretQueryExprOutline(exp.right, level + 1, sb)
				sb.append('''«Strings.repeat("\t",level)»}
				''')
			}	
			OrExpression: {
				sb.append('''«Strings.repeat("\t",level)»Or
«Strings.repeat("\t",level)»{
				''')
				interpretQueryExprOutline(exp.left, level + 1, sb)
				interpretQueryExprOutline(exp.right, level + 1, sb)
				sb.append('''«Strings.repeat("\t",level)»}
				''')
			}
			NotExpression: {
				sb.append('''«Strings.repeat("\t",level)»Not
				''')
				interpretQueryExprOutline(exp.expression, level + 1, sb)
			}
			SimpleSearch: {
				sb.append('''«Strings.repeat("\t",level)»SimpleSearch [query: «exp.query»]
				''')
			}
			KeywordSearch: {
				sb.append('''«Strings.repeat("\t",level)»KeywordSearch [query: «exp.query»]
				''')
			}
			ExactlySearch: {
				sb.append('''«Strings.repeat("\t",level)»ExactlySearch [query: «exp.query»]
				''')
			}
			UserSearch: {
				sb.append('''«Strings.repeat("\t",level)»UserSearch [query: «exp.query»]
				''')
			}
			AllSearch: {
				sb.append('''«Strings.repeat("\t",level)»AllSearch
				''')
			}
		}
	}
	
	def String processModelOutline(Model m) {
		var level = 0
    	val sb = new StringBuilder()
    	
    	//Process Model
    	sb.append('''Model [queries: «m.queries.length»]
    	''')
    	level++

    	//Process Queries
    	m.queries.forEach[ element, index |
    		switch(element) {
    			SimpleQuery: {
    				sb.append('''	#«index» SimpleQuery
					''')
    			}
    			BioQuery: {
    				sb.append('''	#«index» BioQuery
					''')
    			}
    			PostQuery: {
    				sb.append('''	#«index» PostQuery
					''')
    			}
    			CommentsQuery: {
    				sb.append('''	#«index» CommentsQuery [postId: «element.postId»]
					''')
    			}
    			ResponseQuery: {
    				sb.append('''	#«index» ResponseQuery [userId: «element.userId»]
					''')
    			}
    		}
    		interpretQueryExprOutline(element.queryExpression, 2, sb)
		]
		
		//Process SearchBy
		if(m.searchMode !== null)
			sb.append('''	SearchMode[mode: «m.searchMode.mode»]
					  ''')
					  
    	//Process SearchLang
    	if(m.searchLang !== null)
    		sb.append('''	SearchLang[lang: «m.searchLang.lang»]
					  ''')
		
		//Process SearchLocation
		if(m.searchLocation !== null)
			sb.append('''	SearchLocation[location: («m.searchLocation.lat»,«m.searchLocation.lon»,«if(m.searchLocation.area === null) 0 else m.searchLocation.area.radius »)]
					  ''')
    	
    	//Process SearchDate
    	if(m.searchDate !== null)
			sb.append('''	SearchDate[from: «m.searchDate.from», to: «m.searchDate.to»]
					  ''')
    	
    	//Process RepeatOptions
    	if(m.repeatOptions !== null)
			sb.append('''	RepeatOptions[every: «m.repeatOptions.every», to: «if(m.repeatOptions.until === null) 0 else m.repeatOptions.until.value»]
					  ''')
		
		//Process Platform
		if(m.platforms !== null && m.platforms.size() != 0) {
			sb.append('''	Platforms
					  ''')
			m.platforms.forEach [p |
				sb.append('''		«p.platform»
					  ''')
			]
		}

		//Process Limit
		if(m.limit !== null)
    		sb.append('''	Limit «m.limit.limit»
					  ''')
		
		//Process Delay
		if(m.delay !== null)
    		sb.append('''	Delay «m.delay.delay»
					  ''')

    	sb.toString
	}
}