# Benchmarks

- [CompareIterate](./build/CompareIterate.html)
- [CompareIterateAndModify](./build/CompareIterateAndModify.html)
- [CompareIterateAndModify2](./build/CompareIterateAndModify2.html)
- [ScaleIterate](./build/ScaleIterate.html)
- [scaleIterateAndModify](./build/scaleIterateAndModify.html)
- [scaleIterateAndModify2](./build/scaleIterateAndModify2.html)

## History

### 1. record of dicts

### 2. record of arrays

### 3. record of dicts with node caching

### 4. record of arrays with node caching

### 4b. record of arrays with node caching

### 5. array of records with node caching

## Demo System Operations

- Animation: iterate (A)B -> insert A
- Collection: iterate AB x iterate AC -> sometimes remove C, insert DE, update F
- KeyControls: iterate (A)B -> insert A
- MotionControl: iterate ABCD -> insert A
- Movement: iterate AB -> insert A
- Render: iterate AB
- Spawn: create with ABCDEF...
- Transform: iterate A -> insert A & sometimes destroy & sometimes insert B
