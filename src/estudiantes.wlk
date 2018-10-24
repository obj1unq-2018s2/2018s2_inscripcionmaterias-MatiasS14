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
	
	method materiaEsDeCarrera(materia)= carreras.any{carrera => materia.perteneceACarrera(carrera)}
	
	method cumpleMateriasCorrelativas(materia)= materia.materiasCorrelativas().intersection( materiasAprobadas ) ==
																					 materia.materiasCorrelativas()
	
	method cumplePrerrequisitosMateria(materia)= materia.puedeInscribirse(self)
	
	method totalCreditos()= totalCreditos
	
	method agregarCreditos(credito){ totalCreditos += credito} 
	
	method tieneCreditosSuficientes(materia) = totalCreditos == materia.creditosNecesarios() 
	
	method aproboMateriasDeAnio(anio){
		return true
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
		
		if(self.puedeCursar(materia) and ! materia.haySobrecupo()){
			
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
	
	method materiasEnLasQueEstaInscripto(estudiante)=
		estudiante.carreras().all{carrera=> estudiante.materiasQueCursa(carrera)}
	
	
	method materiasQueCursa(carrera)= carrera.materiasDeLaCarrera().all{ materia => self.estaInscriptoA(materia) }
	
	method materiasEnListaDeEspera(estudiante)=
		estudiante.carreras().all{carrera=> estudiante.materiasEnEspera(carrera)}
	
	
	method materiasEnEspera(carrera)= carrera.materiasDeLaCarrera().all{ materia => materia.listaDeEspera().contains(self) }
	
	
}
