import Head from "next/head";
import styles from "../styles/Home.module.css";

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Eelis Kostiainen</title>
        <meta name="description" content="Eelis Kostiainen homepage" />
        <link rel="icon" href="/favicon.svg" />
      </Head>

      <main className={styles.main}>
        <h3>Eelis Kostiainen</h3>
      </main>
    </div>
  );
}
