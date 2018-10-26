class Materia {
	const property curso
	
	var property cupos
	
	var property alumnosInscriptos= #{}
	
	var property listaDeEspera=#{}
	
	var property materiasCorrelativas
	
	var property creditosAlAprobar
	
	var property anioMateria
	
	var property creditosNecesarios		
	
	method perteneceACarrera(carrera) = carrera.materiasDeLaCarrera().contains(self)
	
	method puedeInscribirse(estudiante)= 
	 estudiante.cumpleMateriasCorrelativas(self) and estudiante.tieneCreditosSuficientes(self)
	  and estudiante.aproboMateriasDeAnio(anioMateria-1)
	
	method haySobrecupo()= cupos <= alumnosInscriptos.size()
	
	method inscribirAlumno(estudiante){ alumnosInscriptos.add(estudiante) }
	
	method alumnoAListaDeEspera(estudiante){ listaDeEspera.add(estudiante) }
	
	//mensajes para que entrar a lista de espera por promedio
	
//	method alumnoAListaDeEspera(estudiante){
//		if(estudiante.promedio() > self.promedioMasBajoEnEspera()){
//			listaDeEspera.Add(estudiante)
//		}
//	}
//	
//	method promedioMasBajoEnEspera()= listaDeEspera.min{alumno=> alumno.promedio()}

	//mensajes para entran en lista de espera por avance de carrera
	
//	method alumnoAListaDeEspera(estudiante){
//		if( estudiante.avanceDeCarrera() > self.masAtrazadoDeCarrera() ){
//			listaDeEspera.Add(estudiante)
//		}
//	}
//	
//	method masAtrazadoDeCarrera()=listaDeEspera.min{alumno=> alumno.avanceDeCarrera()}
	
	method darDeBajaAlumno(estudiante){
		
		if( ! listaDeEspera.isEmpty() ){
			
			alumnosInscriptos.remove(estudiante)
			alumnosInscriptos.add( listaDeEspera.first() )
			listaDeEspera.remove( listaDeEspera.first() )
		}
		else{
			alumnosInscriptos.remove(estudiante)
		}
	}
	
		
}

class MateriaAprobada{
	const property materia
	const property nota
}
