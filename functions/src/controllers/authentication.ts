import { collection, query, where, getDocs } from "firebase/firestore";
import { logger } from "firebase-functions";
type Authresult = [boolean, string];
async function authenticate_client(
  property_name: string,
  unit_num: number,
  social: string,
  db_connection: any
): Promise<Authresult> {
  const ResidentRef = collection(db_connection, "resident");
  const q = query(
    ResidentRef,
    where("property_name", "==", property_name),
    where("unit_num", "==", unit_num)
  );

  getDocs(q).then((docs) => {
    if (docs.empty) {
      return [false, "property not found"];
    }
    const matchingDoc = docs.docs.find((doc) => doc.data().social === social);
    if (matchingDoc) {
      logger.log(matchingDoc.id, " => ", matchingDoc.data());
      return [true, matchingDoc.data().uid];
    } else {
      return [false, "social does not match"];
    }
  });

  return [false, "social does not match"];
}
export { authenticate_client };
