import { useState, useEffect } from "react";
import { StyleSheet, View, Text, TouchableOpacity, FlatList, AppState } from "react-native";
import AsyncStorage from '@react-native-async-storage/async-storage';
import 'react-native-get-random-values';
import { v4 as uuidv4 } from 'uuid';
import { mynancePurple, saveItems, retrieveItems } from "../../utils";
import Transaction from "../../TransactionsClass";

import BalanceView from "./BalanceView";
import AddTransaction from "../AddTransaction/AddTransaction";
import ListItem from "./ListItem";

export default function HomeScreen() {
    useEffect(() => {
      AppState.addEventListener("change", async() => {
        const currentState = AppState.currentState;

        if(currentState === "inactive") {
          await saveItems();
        } else if(currentState === "active") {
          setTransactions(await retrieveItems());
        }

      })
    });

    const [modalVisible, setModalVisible] = useState(false);
    const [transactions, setTransactions] = useState([]);

    const totalBalance = transactions.filter((transaction) => transaction.amount).reduce((previousValue, currentValue) => {
      return previousValue += currentValue.amount;
    }, 0)

    const addTransaction = (title, amount, description) => {
      const transactionsCopy = transactions.slice();

      const newTransaction = new Transaction(title, description, amount, uuidv4());
      transactionsCopy.push(newTransaction);

      setTransactions(transactionsCopy);
    }
    
    const deleteTransaction = (id) => {
      const transactionCopy = transactions.filter((transaction) => transaction.id !== id);

      setTransactions(transactionCopy);
    }

    const renderItem = ({ item }) => (
      <View style={{marginVertical: 10}}>
        <ListItem  transaction={item} deleteTransaction={deleteTransaction} />
      </View>
    );

    return (
      <View>
        <View style={styles.upperContainer}>
          <BalanceView balance={totalBalance}/>

          <TouchableOpacity onPress={() => setModalVisible(true)}  style={styles.transactionButton}>
            <Text style={styles.headingText}>New Transaction</Text>
          </TouchableOpacity>
        </View>

        <View style={{height: "70%"}}>
        <FlatList
        data={transactions}
        renderItem={renderItem}
        keyExtractor={item => item.id}
      />
        </View>

        <AddTransaction modalVisible={modalVisible} setModalVisible={setModalVisible} addTransaction={addTransaction}/>
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
  },
})