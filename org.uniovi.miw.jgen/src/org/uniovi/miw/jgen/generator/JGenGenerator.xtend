/*
 * generated by Xtext 2.16.0
 */
package org.uniovi.miw.jgen.generator

import com.google.gson.GsonBuilder
import java.util.List
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.uniovi.miw.jgen.generator.model.JGenBaseObject
import org.uniovi.miw.jgen.generator.model.JGenDateObject
import org.uniovi.miw.jgen.generator.model.JGenLocationObject
import org.uniovi.miw.jgen.generator.model.JGenQueryObject
import org.uniovi.miw.jgen.jGen.Model
import org.uniovi.miw.jgen.jGen.Platform
import org.uniovi.miw.jgen.jGen.Query
import org.uniovi.miw.jgen.jGen.SearchDate
import org.uniovi.miw.jgen.jGen.SearchLocation
import java.util.LinkedList
import org.uniovi.miw.jgen.jGen.SimpleQuery
import org.uniovi.miw.jgen.jGen.BioQuery
import org.uniovi.miw.jgen.jGen.CommentsQuery
import org.uniovi.miw.jgen.jGen.ResponseQuery
import org.uniovi.miw.jgen.jGen.QueryExpression
import org.uniovi.miw.jgen.generator.model.JGenExpressionObject
import org.uniovi.miw.jgen.jGen.PostQuery
import org.uniovi.miw.jgen.jGen.AndExpression
import org.uniovi.miw.jgen.jGen.OrExpression
import org.uniovi.miw.jgen.jGen.NotExpression
import org.uniovi.miw.jgen.jGen.SimpleSearch
import org.uniovi.miw.jgen.jGen.KeywordSearch
import org.uniovi.miw.jgen.jGen.ExactlySearch
import org.uniovi.miw.jgen.jGen.UserSearch
import org.uniovi.miw.jgen.jGen.AllSearch

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class JGenGenerator extends AbstractGenerator {
	
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		
		if(resource.errors.size() != 0) {
			fsa.generateFile('query.jgen', "Error processing query\n" + resource.errors.map[e | e.message].join(","))
			return
		}
		
		var model = resource.allContents.findFirst[x | x instanceof Model] as Model
		
		try {				
			fsa.generateFile('config.json', processModel(model))
		} catch (Exception e) {
			fsa.generateFile('error', "Error processing query\n" + e.message)
		}
	}
	
	private def String processModel(Model m) {
		 val builder = new GsonBuilder();
		 val gson = builder.setPrettyPrinting().create();
		 
		 val result = new JGenBaseObject(
		 	m.queries.length,                              //queryNumber
		 	processQueries(m.queries),                     //queries	
		 	processPlatforms(m.platforms),                 //platforms
		 	processLocation(m.searchLocation),             //location 
		 	processDate(m.searchDate),                     //dates 
		 	m.searchMode?.mode,                            //searchMode
		 	m.searchLang?.lang,                            //lang
		 	if(m.limit === null) null else m.limit.limit,  //maxResults
		 	if(m.repeatOptions === null) null 
		 		else m.repeatOptions.every,                //interval
		 	if(m.repeatOptions === null) null 
		 		else if(m.repeatOptions.until === null)
		 			null else m.repeatOptions.until.value, //endIn
		 	if(m.delay === null) null else m.delay.delay   //delay
		 )
		 
		 gson.toJson(result)
	}
	
	private def List<JGenQueryObject> processQueries(List<Query> queries) {
		val result = new LinkedList<JGenQueryObject>()
		
		for (query : queries) {
			switch(query) {
				SimpleQuery: {
					result.addLast(new JGenQueryObject(
						"PostQuery",
						null,
						processExpression(query.queryExpression)
					))
				}
				PostQuery: {
					result.addLast(new JGenQueryObject(
						"PostQuery",
						null,
						processExpression(query.queryExpression)
					))
				}
				BioQuery: {
					result.addLast(new JGenQueryObject(
						"UserQuery",
						null,
						processExpression(query.queryExpression)
					))
				}
				CommentsQuery: {
					result.addLast(new JGenQueryObject(
						"CommentsQuery",
						query.postId,
						processExpression(query.queryExpression)
					))
				}
				ResponseQuery: {
					result.addLast(new JGenQueryObject(
						"ResponseQuery",
						query.userId,
						processExpression(query.queryExpression)
					))
				}
				default: {
					throw new IllegalArgumentException("Wrong Query Type")
				}
			}
		}
		
		return result
	}
	
	private def JGenExpressionObject processExpression(QueryExpression exp) {
		switch(exp) {
			AndExpression: {
				return new JGenExpressionObject(
					"AND",
					true,
					processExpression(exp.left),
					processExpression(exp.right),
					null
				)
			}	
			OrExpression: {
				return new JGenExpressionObject(
					"OR",
					true,
					processExpression(exp.left),
					processExpression(exp.right),
					null
				)
			}
			NotExpression: {
				return new JGenExpressionObject(
					"NOT",
					true,
					processExpression(exp.expression),
					null,
					null
				)
			}
			SimpleSearch: {
				return new JGenExpressionObject(
					"SIMPLE",
					false,
					null,
					null,
					exp.query
				)
			}
			KeywordSearch: {
				return new JGenExpressionObject(
					"KEYWORD",
					false,
					null,
					null,
					exp.query
				)
			}
			ExactlySearch: {
				return new JGenExpressionObject(
					"EXACTLY",
					false,
					null,
					null,
					exp.query
				)
			}
			UserSearch: {
				return new JGenExpressionObject(
					"USER",
					false,
					null,
					null,
					exp.query
				)
			}
			AllSearch: {
				return new JGenExpressionObject(
					"ALL",
					false,
					null,
					null,
					null
				)
			}
		}
	}
	
	private def JGenDateObject processDate(SearchDate sd) {
		if(sd === null)
			return null
	
		return new JGenDateObject(
			sd.from,
			sd.to
		)
	}
	
	private def JGenLocationObject processLocation(SearchLocation sl) {
		if(sl === null)
			return null
	
		return new JGenLocationObject(
			sl.lat,
			sl.lon,
			if(sl.area === null) null else sl.area.radius
		)
	}
	
	private def List<String> processPlatforms(List<Platform> platforms) {
		if(platforms.size() == 0) {
			return #["twitter", "facebook"]
		}
		
		if(platforms.get(0).platform.equals("*")){
			return #["twitter", "facebook"]
		}
		
		return platforms.map[p | p.platform.toLowerCase]
	}
	
}
