import { Swipeable } from "react-native-gesture-handler";
import { StyleSheet, View, Text, TouchableOpacity, FlatList, Animated } from "react-native";

export default function ListItem({ transaction, deleteTransaction }) {
    const { title, description, amount, id } = transaction;
    
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
            <View style={styles.item}>
                <Text style={styles.title}>{title}</Text>
            </View>
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
        backgroundColor: '#f9c2ff',
        padding: 20,
        marginHorizontal: 16
    },

    title: {
        fontSize: 32,
    }
})