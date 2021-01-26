package org.uniovi.miw.jgen.tests

import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import org.uniovi.miw.jgen.jGen.Model
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.uniovi.miw.jgen.interpreter.JGenInterpreter
import org.junit.jupiter.api.TestInfo
import org.junit.jupiter.api.BeforeEach
import org.eclipse.xtext.diagnostics.Severity
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import java.util.ArrayList

@ExtendWith(InjectionExtension)
@InjectWith(JGenInjectorProvider)
class JGenValidationTest {
	
	@Inject extension ParseHelper<Model> parseHelper
	@Inject extension ValidationTestHelper
	@Inject JGenInterpreter interpreter
	@Inject TestFilesLoader loader
	
	@BeforeEach 
	def void beforeEach(TestInfo info) {
		val testName = info.displayName
		 
		loader.loadInput(testName.substring(15, testName.length - 2), "validation")
		loader.loadOutput(testName.substring(15, testName.length - 2), "validation")
		
		if(testName.contains("Experimental")) {
			return
		}
		
		if (loader.input === null) {
			throw new Exception("Test file not found")
		}
				
		if(testName.contains("Error")){
			val result = loader.input.parse
			val issues = validate(result)
			if(!(issues.exists[i | i.severity == Severity.ERROR])){
				throw new AssertionError("An invalid program was validated");
			}
			
			val errors = loader.output.split("\n");
			
			val errorList = new ArrayList<String>(errors.map[x | x.trim()]);
			
			if(errors.length !== issues.length){
				throw new AssertionError("The output number of errors does not match");
			}
			
			//Comprobar mensaje de error
			issues.forEach[i, index |
				if(errorList.contains(i.message)) {
					errorList.remove(i.message);
				} else { 
					Assertions.assertEquals(i.message, errorList.get(0))
				}
			]
			
			return
		}

		val result = loader.input.parse
		Assertions.assertNotNull(result)
		result.assertNoErrors
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
		
		if(loader.output === null) {
			Assertions.fail("No test output")
			return
		}
		
		val modelString = interpreter.processModelOutline(result)
		Assertions.assertEquals(modelString.trim(), loader.output.trim())
    }
	
// #Automated Section

	/*
	 * Basic TESTS
	 */

	@Test
	def void ValidationTest_Basic_ExactlySearchLength() {}

	@Test
	def void ValidationTest_Basic_KeywordSearchLength() {}

	@Test
	def void ValidationTest_Basic_PlatformAll() {}

	@Test
	def void ValidationTest_Basic_RepeatOptions() {}

	@Test
	def void ValidationTest_Basic_SearchArea() {}

	@Test
	def void ValidationTest_Basic_SearchArea2() {}

	@Test
	def void ValidationTest_Basic_SearchArea3() {}

	@Test
	def void ValidationTest_Basic_SearchDate() {}

	@Test
	def void ValidationTest_Basic_SearchDelay() {}

	@Test
	def void ValidationTest_Basic_SearchDelay2() {}

	@Test
	def void ValidationTest_Basic_SearchLang() {}

	@Test
	def void ValidationTest_Basic_SearchLimit() {}

	@Test
	def void ValidationTest_Basic_SearchLimit2() {}

	@Test
	def void ValidationTest_Basic_SearchLocation() {}

	@Test
	def void ValidationTest_Basic_SearchLocation10() {}

	@Test
	def void ValidationTest_Basic_SearchLocation2() {}

	@Test
	def void ValidationTest_Basic_SearchLocation3() {}

	@Test
	def void ValidationTest_Basic_SearchLocation4() {}

	@Test
	def void ValidationTest_Basic_SearchLocation5() {}

	@Test
	def void ValidationTest_Basic_SearchLocation6() {}

	@Test
	def void ValidationTest_Basic_SearchLocation7() {}

	@Test
	def void ValidationTest_Basic_SearchLocation8() {}

	@Test
	def void ValidationTest_Basic_SearchLocation9() {}

	@Test
	def void ValidationTest_Basic_SimpleSearchLength() {}

	@Test
	def void ValidationTest_Basic_UserSearchLength() {}

	/*
	 * ERROR TESTS
	 */

	@Test
	def void ValidationTest_Error_Delay() {}

	@Test
	def void ValidationTest_Error_Delay2() {}

	@Test
	def void ValidationTest_Error_ExactlySearchLength() {}

	@Test
	def void ValidationTest_Error_KeywordSearchLength() {}

	@Test
	def void ValidationTest_Error_Limit() {}

	@Test
	def void ValidationTest_Error_Limit2() {}

	@Test
	def void ValidationTest_Error_PlatformAll() {}

	@Test
	def void ValidationTest_Error_PlatformAll2() {}

	@Test
	def void ValidationTest_Error_PlatformDuplicated() {}

	@Test
	def void ValidationTest_Error_PlatformDuplicated2() {}

	@Test
	def void ValidationTest_Error_PlatformDuplicated3() {}

	@Test
	def void ValidationTest_Error_PlatformDuplicated4() {}

	@Test
	def void ValidationTest_Error_SearchArea() {}

	@Test
	def void ValidationTest_Error_SearchArea2() {}

	@Test
	def void ValidationTest_Error_SearchArea3() {}

	@Test
	def void ValidationTest_Error_SearchLang() {}

	@Test
	def void ValidationTest_Error_SearchLang2() {}

	@Test
	def void ValidationTest_Error_SimpleSearchLength() {}

	@Test
	def void ValidationTest_Error_UserSearchLength() {}

	@Test
	def void ValidationTest_Error_ValidPlatform() {}

	@Test
	def void ValidationTest_Error_ValidPlatform2() {}

	@Test
	def void ValidationTest_Error_ValidSearchMode() {}

// #End Section

}
