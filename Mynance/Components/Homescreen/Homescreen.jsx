import { useState } from "react";
import { StyleSheet, View, Text, TouchableOpacity } from "react-native";
import { mynancePurple, Transaction } from "../../utils";

import BalanceView from "./BalanceView";
import AddTransaction from "../AddTransaction/AddTransaction";

export default function HomeScreen() {

    const [modalVisible, setModalVisible] = useState(false);
    
    return (
      <View>
        <View style={styles.upperContainer}>
          <BalanceView balance={10000}/>

          <TouchableOpacity onPress={() => setModalVisible(true)}  style={styles.transactionButton}>
            <Text style={styles.headingText}>New Transaction</Text>
          </TouchableOpacity>
        </View>

        <View style={{height: "70%"}}>
          
        </View>

        <AddTransaction modalVisible={modalVisible} setModalVisible={setModalVisible}/>
      </View>
    );
  }
  
const styles = StyleSheet.create({
  upperContainer: {
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "space-around",

    height: "40%"
  },

  transactionButton: {
    width: "80%",
    marginHorizontal: "auto",
    paddingVertical: 20,
    paddingHorizontal: 10,
    borderRadius: 10,

    backgroundColor: mynancePurple,
    shadowColor: '#171717',
    shadowOffset: {width: -2, height: 4},
    shadowOpacity: 0.3,
    shadowRadius: 3,
  },

  headingText: {
    textAlign: "center",
    color: "white",
    fontSize: 15,
    fontWeight: "bold"
  }
})