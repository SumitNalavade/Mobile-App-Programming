import { useState } from "react";
import { StyleSheet, View, Text, TouchableOpacity } from "react-native";
import { mynancePurple } from "../../utils";

import BalanceView from "./BalanceView";

export default function HomeScreen() {

  const [balance, setBalance] = useState(0);
  const changeBalance = (type, changeValue) => {
      let newBalance = balance;

      if(type === "increase") { newBalance += changeValue}
      else if(type === "decrease") { newBalance -= changeValue}

      return newBalance > 0 ? setBalance(newBalance) : setBalance(0);
  }

    return (
      <View>
        <View style={styles.upperContainer}>
          <BalanceView balance={balance}/>

          <TouchableOpacity style={styles.transactionButton}>
            <Text style={{textAlign: "center", color: "white", fontSize: 15, fontWeight: "bold"}}>New Transaction</Text>
          </TouchableOpacity>
        </View>

        <View style={{height: "70%"}}>
          
        </View>
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
  }
})