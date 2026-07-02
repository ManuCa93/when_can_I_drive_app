import json
import os

langs = {
    'en': {
        'calculationExplanationTitle': "How is BAC calculated?",
        'calculationExplanationBody': "This app uses the modified Widmark formula to mathematically estimate your Blood Alcohol Concentration (BAC).\n\nWHAT AFFECTS THE CALCULATION:\n• Weight and gender (they determine the water content in your body).\n• Alcohol volume and ABV.\n• Stomach state AT THE TIME of drinking (food slows down alcohol absorption).\n\nWHAT DOES NOT AFFECT IT (Myths):\n• Eating AFTER drinking: the alcohol is already in your bloodstream, food doesn't absorb it or help the liver process it faster.\n• Drinking coffee, taking cold showers, or drinking lots of water (water prevents dehydration but doesn't lower BAC).\n• Only TIME allows your liver to metabolize alcohol (approx 0.15 g/l per hour)."
    },
    'it': {
        'calculationExplanationTitle': "Come viene calcolato il BAC?",
        'calculationExplanationBody': "Questa app utilizza la formula di Widmark modificata per stimare matematicamente la concentrazione di alcol nel sangue (BAC).\n\nCOSA INCIDE SUL CALCOLO:\n• Peso e sesso (determinano la quantità di acqua nel corpo).\n• Gradazione e volume del drink.\n• Stato dello stomaco AL MOMENTO dell'assunzione (il cibo rallenta l'assorbimento dell'alcol).\n\nCOSA NON INCIDE (Falsi miti):\n• Mangiare DOPO aver bevuto: l'alcol è già in circolo, il cibo non lo assorbe né aiuta il fegato a smaltirlo.\n• Bere caffè, fare docce fredde o bere tanta acqua (l'acqua previene la disidratazione ma non abbassa il BAC).\n• Solo il TEMPO permette al fegato di metabolizzare l'alcol (circa 0.15 g/l all'ora)."
    },
    'es': {
        'calculationExplanationTitle': "¿Cómo se calcula el BAC?",
        'calculationExplanationBody': "Esta aplicación utiliza la fórmula de Widmark modificada para estimar matemáticamente su concentración de alcohol en sangre (BAC).\n\nQUÉ AFECTA EL CÁLCULO:\n• Peso y sexo (determinan la cantidad de agua en su cuerpo).\n• Volumen y graduación alcohólica.\n• Estado del estómago EN EL MOMENTO de beber (la comida ralentiza la absorción del alcohol).\n\nQUÉ NO LO AFECTA (Mitos):\n• Comer DESPUÉS de beber: el alcohol ya está en el torrente sanguíneo, la comida no lo absorbe ni ayuda al hígado a procesarlo más rápido.\n• Tomar café, duchas frías o beber mucha agua (el agua previene la deshidratación pero no reduce el BAC).\n• Solo el TIEMPO permite que el hígado metabolice el alcohol (aprox. 0.15 g/l por hora)."
    },
    'fr': {
        'calculationExplanationTitle': "Comment le taux d'alcoolémie est-il calculé ?",
        'calculationExplanationBody': "Cette application utilise la formule de Widmark modifiée pour estimer mathématiquement votre taux d'alcool dans le sang (BAC).\n\nCE QUI AFFECTE LE CALCUL :\n• Le poids et le sexe (ils déterminent la quantité d'eau dans votre corps).\n• Le volume et le degré d'alcool.\n• L'état de l'estomac AU MOMENT de la consommation (la nourriture ralentit l'absorption de l'alcool).\n\nCE QUI NE L'AFFECTE PAS (Mythes) :\n• Manger APRÈS avoir bu : l'alcool est déjà dans le sang, la nourriture ne l'absorbe pas et n'aide pas le foie à l'éliminer.\n• Boire du café, prendre une douche froide ou boire beaucoup d'eau (l'eau prévient la déshydratation mais ne fait pas baisser l'alcoolémie).\n• Seul le TEMPS permet au foie de métaboliser l'alcool (environ 0.15 g/l par heure)."
    },
    'de': {
        'calculationExplanationTitle': "Wie wird die BAK berechnet?",
        'calculationExplanationBody': "Diese App verwendet die modifizierte Widmark-Formel, um Ihre Blutalkoholkonzentration (BAK) mathematisch zu schätzen.\n\nWAS DIE BERECHNUNG BEEINFLUSST:\n• Gewicht und Geschlecht (sie bestimmen den Wassergehalt in Ihrem Körper).\n• Volumen und Alkoholgehalt.\n• Magenzustand ZUM ZEITPUNKT des Trinkens (Nahrung verlangsamt die Alkoholaufnahme).\n\nWAS SIE NICHT BEEINFLUSST (Mythen):\n• Essen NACH dem Trinken: Der Alkohol ist bereits im Blutkreislauf, Nahrung absorbiert ihn nicht und hilft der Leber nicht beim Abbau.\n• Kaffee trinken, kalt duschen oder viel Wasser trinken (Wasser verhindert Dehydration, senkt aber nicht die BAK).\n• Nur ZEIT ermöglicht es der Leber, Alkohol abzubauen (ca. 0,15 g/l pro Stunde)."
    }
}

l10n_dir = r"C:\Users\manuc\Documents\sobertrack_app\lib\l10n"

for filename in os.listdir(l10n_dir):
    if filename.endswith(".arb"):
        lang = filename.split("_")[1].split(".")[0]
        filepath = os.path.join(l10n_dir, filename)
        
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
            
        if lang in langs:
            data['calculationExplanationTitle'] = langs[lang]['calculationExplanationTitle']
            data['calculationExplanationBody'] = langs[lang]['calculationExplanationBody']
            
            with open(filepath, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
                
print("Done updating arb files.")
