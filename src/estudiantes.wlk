import materias.*

class Estudiante {
	var property carreras
	var materiasAprobadas= #{}
	var totalCreditos = 0
	
	
	method puedeCursar(materia) {
		return self.cumpleRequisitosdeInscripcionA(materia)
	}
	
	method cumpleRequisitosdeInscripcionA(materia){
		
		return !self.aprobo(materia) and !self.estaInscriptoA(materia) and
		
			    self.materiaEsDeCarrera(materia) and self.cumplePrerrequisitosMateria(materia)
	}
	
	method aprobo(materia)= materiasAprobadas.contains(materia)
	
	method estaInscriptoA(materia) = materia.alumnosInscriptos().contains(self)
	
	method materiaEsDeCarrera(materia)= carreras.any{carrera =>
		
		materia.perteneceACarrera(carrera)
	}
	
	method cumpleMateriasCorrelativas(materia)= 
	
		materia.materiasCorrelativas().intersection( materiasAprobadas) ==
		
		materia.materiasCorrelativas()
	
	method cumplePrerrequisitosMateria(materia)= materia.puedeInscribirse(self)
	
	method totalCreditos()= totalCreditos
	
	method agregarCreditos(credito){ totalCreditos += credito} 
	
	method tieneCreditosSuficientes(materia) = totalCreditos == materia.creditosNecesarios() 
	
	method aproboMateriasDeAnio(anio){
		
		return 	materiasAprobadas.contains(self.materiasDeAnio(anio))
	}
	
	method materiasDeAnio(anio){
		return self.carreras().flatMap{carrera=>
			
			carrera.materiasDeLaCarrera()
			
		}.filter{materia =>materia.anioMateria()==anio}
	}
	
	method registrarMateriaAprobada(materia,nota){
		var materiaPorAgregar= new MateriaAprobada(materia=materia, nota=nota)
		
		if( !self.aprobo(materia) ){
			
			self.agregarCreditos(materia.creditosAlAprobar())
			materiasAprobadas.add(materiaPorAgregar)
		}
		
		else{self.error("La Materia Ya Fue Aprobada")
			
		}
	}
	
	method inscribirAMateria(materia){
		
		if(self.puedeCursar(materia) and not materia.haySobrecupo()){
			
			materia.inscribirAlumno(self)
		}
		else{
			
			materia.alumnoAListaDeEspera(self)
		}
	}
	
	method sigueCarrera(carrera) = carreras.contains(carrera)

	method materiasParaCursar(carrera,estudiante){
	
		 if( estudiante.sigueCarrera(carrera) ) { 
		 	
		 	return carrera.materias().all{ materia => estudiante.puedeCursar(materia) }
		 }
		 else{
		 	return estudiante.error("El Alumno No Cursa La Carrera")
		 }
	}
	
	method materiasEnLasQueEstaInscripto(estudiante){
		var materias=#{}
		
		 estudiante.carreras().forEach{ carrera =>
		 	
		 	#{materias,estudiante.materiasQueCursa(carrera)}.flatten()
		 }
		 
		 return materias
	}
	
	method materiasQueCursa(carrera)= carrera.materiasDeLaCarrera().filter{ materia =>
		
		self.estaInscriptoA(materia)
	}
	
	method materiasEnListaDeEspera(estudiante){
		var materias=#{}
		
		 estudiante.carreras().forEach{ carrera =>
		 	 
		 	#{materias,estudiante.materiasEnEspera(carrera)}.flatten()
		 }
		 
		 return materias
	}
	
	
	method materiasEnEspera(carrera)= carrera.materiasDeLaCarrera().filter{ materia =>
		 
		materia.listaDeEspera().contains(self)
	}
	
	method promedio()= materiasAprobadas.sum{ materia => 
		
		materia.nota()} / materiasAprobadas.size() 
	
	method avanceDeCarrera()= materiasAprobadas.size()
	
	
}
