/*
 * generated by Xtext 2.16.0
 */
package org.uniovi.miw.jgen.ide

import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2
import org.uniovi.miw.jgen.JGenRuntimeModule
import org.uniovi.miw.jgen.JGenStandaloneSetup

/**
 * Initialization support for running Xtext languages as language servers.
 */
class JGenIdeSetup extends JGenStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new JGenRuntimeModule, new JGenIdeModule))
	}
	
}