package org.uniovi.miw.jgen.tests

import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.InjectWith
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.TestInfo
import com.google.inject.Inject
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.eclipse.xtext.util.IAcceptor
import org.eclipse.xtext.xbase.testing.CompilationTestHelper.Result
import org.eclipse.xtext.diagnostics.Severity
import org.eclipse.xtext.testing.extensions.InjectionExtension

@ExtendWith(InjectionExtension)
@InjectWith(JGenInjectorProvider)
class JGenGenerationTest {
	
	@Inject extension CompilationTestHelper
	
	@Inject TestFilesLoader loader
	
	@BeforeEach 
	def void beforeEach(TestInfo info) {
		val testName = info.displayName
		 
		loader.loadInput(testName.substring(15, testName.length - 2), "generation")
		loader.loadOutput(testName.substring(15, testName.length - 2), "generation")
		
		if(testName.contains("Experimental")) {
			return
		}
		
		if (loader.input === null) {
			throw new Exception("Test file not found")
		}
		
		if(testName.contains("Error")) {
			try {
				loader.input.compile(new IAcceptor<CompilationTestHelper.Result>(){
					override void accept(Result r) {
						Assertions.assertTrue(r.errorsAndWarnings.exists[i | i.severity == Severity.ERROR])
					}
				})
			} catch (Exception e) {
				println(e)
			}
			
			return
		}
		
		loader.input.assertCompilesTo(loader.output.replace('\r\n', '\n'))
	}
	
// #Automated Section

	/*
	 * STRUCTURE TESTS
	 */

	@Test
	def void GenerationTest_Basic_BioQuery() {}

	@Test
	def void GenerationTest_Basic_BioSimple() {}

	@Test
	def void GenerationTest_Basic_CommentsQuery() {}

	@Test
	def void GenerationTest_Basic_Exactly() {}

	@Test
	def void GenerationTest_Basic_ExactlyOneLetter() {}

	@Test
	def void GenerationTest_Basic_ExactlySearchLength() {}

	@Test
	def void GenerationTest_Basic_Expression_And() {}

	@Test
	def void GenerationTest_Basic_Expression_And2() {}

	@Test
	def void GenerationTest_Basic_Expression_AndOr() {}

	@Test
	def void GenerationTest_Basic_Expression_AndOr2() {}

	@Test
	def void GenerationTest_Basic_Expression_Not() {}

	@Test
	def void GenerationTest_Basic_Expression_Parenthesis() {}

	@Test
	def void GenerationTest_Basic_Expression_Parenthesis2() {}

	@Test
	def void GenerationTest_Basic_Expression_Parenthesis3() {}

	@Test
	def void GenerationTest_Basic_Expression_Parenthesis4() {}

	@Test
	def void GenerationTest_Basic_FourSimpleQueries() {}

	@Test
	def void GenerationTest_Basic_Keyword() {}

	@Test
	def void GenerationTest_Basic_Keyword2() {}

	@Test
	def void GenerationTest_Basic_Keyword3() {}

	@Test
	def void GenerationTest_Basic_Keyword4() {}

	@Test
	def void GenerationTest_Basic_KeywordSearchLength() {}

	@Test
	def void GenerationTest_Basic_KeywordUser() {}

	@Test
	def void GenerationTest_Basic_KeywordUser2() {}

	@Test
	def void GenerationTest_Basic_PlatformGeneration() {}

	@Test
	def void GenerationTest_Basic_PlatformGeneration2() {}

	@Test
	def void GenerationTest_Basic_PlatformGeneration3() {}

	@Test
	def void GenerationTest_Basic_PlatformGeneration4() {}

	@Test
	def void GenerationTest_Basic_PostQuery() {}

	@Test
	def void GenerationTest_Basic_RepeatOptions() {}

	@Test
	def void GenerationTest_Basic_ResponseQuery() {}

	@Test
	def void GenerationTest_Basic_SearchAll() {}

	@Test
	def void GenerationTest_Basic_SearchAll2() {}

	@Test
	def void GenerationTest_Basic_SearchArea() {}

	@Test
	def void GenerationTest_Basic_SearchArea2() {}

	@Test
	def void GenerationTest_Basic_SearchArea3() {}

	@Test
	def void GenerationTest_Basic_SearchDate() {}

	@Test
	def void GenerationTest_Basic_SearchDelay() {}

	@Test
	def void GenerationTest_Basic_SearchDelay2() {}

	@Test
	def void GenerationTest_Basic_SearchLang() {}

	@Test
	def void GenerationTest_Basic_SearchLimit() {}

	@Test
	def void GenerationTest_Basic_SearchLimit2() {}

	@Test
	def void GenerationTest_Basic_SearchLocation() {}

	@Test
	def void GenerationTest_Basic_SearchLocation10() {}

	@Test
	def void GenerationTest_Basic_SearchLocation2() {}

	@Test
	def void GenerationTest_Basic_SearchLocation3() {}

	@Test
	def void GenerationTest_Basic_SearchLocation4() {}

	@Test
	def void GenerationTest_Basic_SearchLocation5() {}

	@Test
	def void GenerationTest_Basic_SearchLocation6() {}

	@Test
	def void GenerationTest_Basic_SearchLocation7() {}

	@Test
	def void GenerationTest_Basic_SearchLocation8() {}

	@Test
	def void GenerationTest_Basic_SearchLocation9() {}

	@Test
	def void GenerationTest_Basic_SimpleSearchLength() {}

	@Test
	def void GenerationTest_Basic_Simplest() {}

	@Test
	def void GenerationTest_Basic_ThreeSimpleQueries() {}

	@Test
	def void GenerationTest_Basic_TwoSimpleQueries() {}

	@Test
	def void GenerationTest_Basic_Unicode() {}

	@Test
	def void GenerationTest_Basic_Unicode2() {}

	@Test
	def void GenerationTest_Basic_User() {}

	@Test
	def void GenerationTest_Basic_User2() {}

	@Test
	def void GenerationTest_Basic_User3() {}

	@Test
	def void GenerationTest_Basic_UserSearchLength() {}

	/*
	 * ERROR TESTS
	 */

// #End Section
}
