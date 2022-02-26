import { StyleSheet, View, Text } from "react-native";
import date from "date-and-time";

import { mynancePurple } from "../../utils";

export default function BalanceView({balance}) {
    let currentDate = new Date();
    const pattern = date.compile('ddd, MMM DD YYYY');
    currentDate = date.format(currentDate, pattern);

    return (
        <View style={styles.container}>
            <View style={styles.innerContainer}>
                <Text style={[styles.text]}>Total Balance</Text>
                <Text style={[styles.text, styles.balanceText]}>${balance}</Text>
                <Text style={[styles.text]}>{currentDate}</Text>
            </View>

        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        width: "90%",
        marginHorizontal: "auto",
        paddingVertical: 40,
        paddingHorizontal: 20,

        backgroundColor: mynancePurple,
        borderRadius: 20,


        shadowColor: '#171717',
        shadowOffset: {width: -2, height: 4},
        shadowOpacity: 0.3,
        shadowRadius: 3,
    },

    innerContainer: {
        flexDirection: "column",
        alignItems: "center"
    },

    text: {
        color: "white",
        fontSize: 15,
        margin: 5
    },

    balanceText: {
        fontSize: 60,
        fontWeight: "bold"
    }
})