shader_type particles;

uniform float scaling_factor: hint_range(10.0, 20.0, 0.1);

const float a = 10.0;
const float b = 28.0;
const float c = 2.6666666667;

float rand_from_seed(in uint seed) {
	int k;
	int s = int(seed);

	if (s == 0) {
		s = 305420679;
	}

	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;

	if (s < 0) {
		s += 2147483647;
	}

	seed = uint(s);

	return float(seed % uint(65536)) / 65535.0;
}

uint hash(uint x) {
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x);

	return x;
}

vec3 get_color_from_position(vec3 position) {
    vec3 normalized_position = (position + scaling_factor) / (2.0 * scaling_factor);
    return normalized_position;
}

void start() {
	uint alt_seed1 = hash(NUMBER + uint(1)   + RANDOM_SEED);
	uint alt_seed2 = hash(NUMBER + uint(27)  + RANDOM_SEED);
	uint alt_seed3 = hash(NUMBER + uint(43)  + RANDOM_SEED);
	uint alt_seed4 = hash(NUMBER + uint(111) + RANDOM_SEED);
	
	CUSTOM.x = rand_from_seed(alt_seed1);

	vec3 position = vec3(
		rand_from_seed(alt_seed2) * 2.0 - 1.0,
		rand_from_seed(alt_seed3) * 2.0 - 1.0,
		rand_from_seed(alt_seed4) * 2.0 - 1.0
	);

	TRANSFORM[3].xyz = position * scaling_factor;
	
    COLOR = vec4(get_color_from_position(TRANSFORM[3].xyz), 1.0);
}

void process() {
    vec4 previous = TRANSFORM[3];

    float x = previous.x;
    float y = previous.y;
    float z = previous.z;

    float dx = (a * (y - x)) * DELTA;
    float dy = (x * (b - z) - y) * DELTA;
    float dz = (x * y - c * z) * DELTA;

    TRANSFORM[3].x += dx;
    TRANSFORM[3].y += dy;
    TRANSFORM[3].z += dz;

	COLOR = vec4(get_color_from_position(TRANSFORM[3].xyz), 1.0);
}
