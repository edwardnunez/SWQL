package org.uniovi.miw.jgen.web

import com.google.inject.Inject
import javax.inject.Singleton
import org.eclipse.xtext.util.internal.Log
import org.eclipse.xtext.web.server.IServiceContext
import org.eclipse.xtext.web.server.InvalidRequestException
import org.eclipse.xtext.web.server.XtextServiceDispatcher
import org.eclipse.xtext.web.server.generator.GeneratorService
import org.eclipse.xtext.web.server.validation.ValidationService

@Log
@Singleton
class JGenXtextServiceDispatcher extends XtextServiceDispatcher {
	
	@Inject
  	GeneratorService generatorService;
  	@Inject
  	ValidationService validationService;
	
	override protected createServiceDescriptor(String serviceType, IServiceContext context) {
		if (serviceType == "generate-all") {
			return getGeneratorAllService(context)
		}
		super.createServiceDescriptor(serviceType, context)
	}
	
	protected def getGeneratorAllService(IServiceContext context)
			throws InvalidRequestException {
		val document = getDocumentAccess(context)
		new ServiceDescriptor => [
			service = [
				try {
					
					val issues = validationService.getResult(document).issues;
				
					val notValid = issues.exists[x | x.severity == "error"]
					
					if(notValid) {
						// Cached
						validationService.getResult(document);
					} else {
						generatorService.getResult(document);
					}
				} catch (Throwable throwable) {
					handleError(throwable)
				}
			]
		]
	}
}