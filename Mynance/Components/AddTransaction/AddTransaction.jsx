import Modal from "react-native-modal";
import { StyleSheet, View, Text, TouchableOpacity } from "react-native";

import AddTransactionForm from "./AddTransactionForm";

const Header = ({ setModalVisible }) => {
  return (
    <View style={{width: "100%"}}>
              <View style={{paddingHorizontal: 20, paddingVertical: 15}}>
                <TouchableOpacity onPress={() => setModalVisible(false)}>
                  <Text style={{color: "#0d6efd", fontSize: 18}}>Back</Text>
                </TouchableOpacity>
              </View>

              <View
              style={{
                width: "100%",
                borderBottomColor: 'lightgray',
                borderBottomWidth: 1,
              }}
              />
      </View>
  )
}

export default function AddTransaction({ modalVisible, setModalVisible, addTransaction }) {
    return (
      <Modal isVisible={modalVisible} onBackdropPress={() => setModalVisible(false)} style={{flexDirection: "row"}}>
          <View style={styles.container}>
            <Header setModalVisible={setModalVisible}/>

            <AddTransactionForm addTransaction={addTransaction} isVisible={modalVisible} setModalVisible={setModalVisible}/>

          </View>
        </Modal>
    );
}

const styles = StyleSheet.create({
  container: {
    height: "95%",
    width: "105%",
    justifyContent: "flex-start",
    alignItems: "center",
    alignSelf: "flex-end",
  
    backgroundColor: "white",
    borderRadius: 20
  }
})