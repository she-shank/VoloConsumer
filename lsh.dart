import 'dart:math';

// A class to represent the Locality-Sensitive Hashing (LSH)
class LSH {
  int numHyperplanes; // Number of random hyperplanes (hash functions)
  int dimensions;     // Dimensionality of input vectors
  List<List<double>> hyperplanes; // List of hyperplanes

  // Constructor to initialize the LSH
  LSH(this.numHyperplanes, this.dimensions) {
    hyperplanes = List<List<double>>.generate(numHyperplanes, (i) => _generateRandomHyperplane(dimensions));
  }

  // Generate a random unit vector (hyperplane)
  List<double> _generateRandomHyperplane(int dimensions) {
    Random rand = Random();
    List<double> hyperplane = List<double>.generate(dimensions, (index) => rand.nextDouble() * 2 - 1);
    
    // Normalize the vector
    double magnitude = sqrt(hyperplane.fold(0.0, (sum, x) => sum + x * x));
    return hyperplane.map((x) => x / magnitude).toList();
  }

  // Compute the dot product between two vectors
  double _dotProduct(List<double> vectorA, List<double> vectorB) {
    assert(vectorA.length == vectorB.length);
    double result = 0.0;
    for (int i = 0; i < vectorA.length; i++) {
      result += vectorA[i] * vectorB[i];
    }
    return result;
  }

  // Hash function to convert a vector into a hash code (binary string)
  String hash(List<double> vector) {
    List<int> hashBits = [];
    for (var hyperplane in hyperplanes) {
      double dotProd = _dotProduct(vector, hyperplane);
      hashBits.add(dotProd >= 0 ? 1 : 0); // 1 if positive, 0 if negative
    }
    return hashBits.join(); // Return the binary string as the hash
  }
}

void main() {
  int numDimensions = 4; // Example: 4D vectors
  int numHyperplanes = 8; // Example: 8 random hyperplanes

  // Create an instance of LSH
  LSH lsh = LSH(numHyperplanes, numDimensions);

  // Example vectors
  List<double> vectorA = [0.1, 0.5, 0.3, 0.7];
  List<double> vectorB = [0.2, 0.4, 0.3, 0.6];
  List<double> vectorC = [-0.1, -0.2, 0.9, 0.7];

  // Hash the vectors
  String hashA = lsh.hash(vectorA);
  String hashB = lsh.hash(vectorB);
  String hashC = lsh.hash(vectorC);

  // Print the hash codes
  print('Hash of vector A: $hashA');
  print('Hash of vector B: $hashB');
  print('Hash of vector C: $hashC');
  
  // Check similarity by comparing hash codes
  if (hashA == hashB) {
    print('Vector A and B are likely similar.');
  } else {
    print('Vector A and B are not similar.');
  }
}
