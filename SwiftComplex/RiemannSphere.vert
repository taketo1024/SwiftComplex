float pi = 3.1415926535897932384626433832795;

vec2 uv = _geometry.texcoords[0];
vec3 p = vec3(_geometry.position);
p /= length(p); // normalize

if(p.x == 0.0 && p.z == 0.0 && p.y > 0.0) {
    uv = vec2(0, 0);
} else {
    float polar = acos(p.y);
    float azi = acos(p.x / length(vec2(p.x, p.z)));
    if(p.z < 0.0) {
        azi = 2.0 * pi - azi;
    }
    
    float r = sin(polar) / (1.0 - cos(polar));
    float x = r * cos(azi);
    float y = -r * sin(azi);
    
    float c = 0.125; // unit-circle
    float d = 0.49 / c;
    
    if(abs(x) > d || abs(y) > d) {
        uv = vec2(0, 0);
    } else {
        uv.x = 0.5 + c * x;
        uv.y = 0.5 + c * y;
    }
}

_geometry.texcoords[0] = uv;