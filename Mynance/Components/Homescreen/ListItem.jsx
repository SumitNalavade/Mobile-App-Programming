import { Swipeable } from "react-native-gesture-handler";
import { StyleSheet, View, Text, TouchableOpacity, Animated } from "react-native";
import { Ionicons, MaterialCommunityIcons } from '@expo/vector-icons'; 
import {mynancePurple} from "../../utils";


export default function ListItem({ transaction, deleteTransaction, navigateToInfo }) {
    const { title, category, amount, id, type } = transaction;

    const Icon = () => {
      switch(category) {
        case "Housing":
          return <Ionicons name="ios-home-outline" size={30} color={mynancePurple} />

        case "Transportation":
          return <Ionicons name="ios-car-sport-outline" size={30} color={mynancePurple} />

        case "Food":
          return <Ionicons name="ios-fast-food-outline" size={30} color={mynancePurple} />

        case "Utilities":
          return <Ionicons name="ios-bulb-outline" size={30} color={mynancePurple} />

        case "Health":
          return <Ionicons name="ios-heart-outline" size={30} color={mynancePurple} />

        case "Savings":
          return <MaterialCommunityIcons name="bank-outline" size={30} color={mynancePurple} />

        case "Personal":
          return <Ionicons name="person-outline" size={30} color={mynancePurple} />

        case "Entertainment":
          return <Ionicons name="ios-game-controller-outline" size={30} color={mynancePurple} />

        case "Other":
          return <MaterialCommunityIcons name="credit-card-multiple-outline" size={30} color={mynancePurple} />
      }
    }

    const leftSwipe = (progress, dragX) => {
        const scale = dragX.interpolate({
          inputRange: [0, 100],
          outputRange: [0, 1],
          extrapolate: 'clamp',
        });
        return (
          <TouchableOpacity onPress={() => deleteTransaction(id)} activeOpacity={0.6} style={{width: "100%"}}>
            <View style={styles.deleteBox}>
              <Animated.Text style={{transform: [{scale: scale}], color: "white"}}>
                Delete
              </Animated.Text>
            </View>
          </TouchableOpacity>
        );
      };

    return (
        <Swipeable renderLeftActions={leftSwipe}>
            <TouchableOpacity style={styles.item} onPress={() => navigateToInfo(transaction)}>
              <View style={{width: "10%"}}>
                <Icon />
              </View>

              <View style={{width: "70%"}}>
                <Text style={styles.title}>{title}</Text>
              </View>

              <View style={{width: "20%"}}>
                <Text style={[styles.amount, { color: type=="Income" ? "green" : "red" }]}>{amount}</Text>
              </View>
            </TouchableOpacity>
        </Swipeable>
    )
}

const styles = StyleSheet.create({
    deleteBox: {
        backgroundColor: 'red',
        flexDirection: "row",
        justifyContent: 'flex-start',
        alignItems: 'center',
        height: "100%",
        width: "100%",
        padding: 10
    },

    item: {
        flexDirection: "row",
        alignItems: "center",

        backgroundColor: 'white',
        borderRadius: 15,
        padding: 10,
        marginHorizontal: 16
    },

    title: {
        fontSize: 20,
        textAlign: "center",
    },

    amount: {
      fontSize: 15,
      textAlign: "center",
      fontWeight: "bold",
    }
})