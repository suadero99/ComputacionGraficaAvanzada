#version 330 core
layout (location = 0) in vec3 in_position;
layout (location = 2) in vec2 in_uv;
layout (location = 3) in vec3 in_normal;

out vec2 our_uv;			//Coordenadas de textura
out vec3 our_normal;
out vec3 fragPos;			//Posición del vertice, para dibujar un pixel

//Uniform: Variables que cambian en tiempo de ejecución
//Estas son para matrices
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

uniform float offsetX;	//Desplazamiento en X de la textura
uniform vec2 scaleUV;	//Cuántas veces se repite

void main(){
	//Transformaciones
	gl_Position = projection * view * model * vec4(in_position, 1.0);	//Posición del vértice
	our_uv = in_uv;
	our_uv.x = our_uv.x + offsetX;
	if(scaleUV.x != 0 && scaleUV.y != 0)
		our_uv *= scaleUV;
	fragPos = vec3(model * vec4(in_position, 1.0));
	our_normal = mat3(transpose(inverse(model))) * in_normal; //Transpuesta de la inversa
}
