package org.uniovi.miw.jgen.tests

import java.nio.file.Files
import java.nio.file.Paths
import java.nio.charset.StandardCharsets
import java.io.IOException

class TestFilesLoader {
	
	String testInput
	String testOutput
	
	def String getInput(){testInput}
	
	def String getOutput(){testOutput}
	
	def void loadInput(String filename, String type) {
		testInput = load('''resources/«type»/«filename».jgen''')
	}
	
	def void loadOutput(String filename, String type) {
		val ext = switch type {
			case "validation": "outline"
			case "parsing": "outline"
			case "generation": "json"
			default : ""
		}
		testOutput = load('''resources/«type»/«filename».jgen.«ext»''')
	}
	
	def private load(String filename) {
		try {
			val encoded = Files.readAllBytes(Paths.get(filename))
  			new String(encoded, StandardCharsets.UTF_8)
  		} catch(IOException e) {
  			null
  		}
	}
}