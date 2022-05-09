#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom modeling after compile-HelloWorld.sh below

cd contracts/circuits

mkdir MultiplierThree

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling Multiplier3.circom..."

# compile circuit

circom Multiplier3.circom --r1cs --wasm --sym -o MultiplierThree
snarkjs r1cs info MultiplierThree/Multiplier3.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup MultiplierThree/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau MultiplierThree/circuit_0000.zkey
snarkjs zkey contribute MultiplierThree/circuit_0000.zkey MultiplierThree/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey MultiplierThree/circuit_final.zkey MultiplierThree/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier MultiplierThree/circuit_final.zkey ../Multiplier3GrothVerifier.sol

cd ../..