import {
    Table,
    TableHeader,
    TableBody,
    TableHead,
    TableRow,
    TableCell,
    TableCaption,
} from '@/components/ui/table';

export function TableDashboard({ tabledata }: { tabledata: any[] }) {
    return (
        <Table>
            <TableCaption>Liste des dernières opportunités.</TableCaption>
            <TableHeader>
                <TableRow>
                    <TableHead className="w-[100px]">Client</TableHead>
                    <TableHead>Type</TableHead>
                    <TableHead>Statut</TableHead>
                    <TableHead className="text-right">Montant</TableHead>
                </TableRow>
            </TableHeader>
            <TableBody>
                {tabledata.map((opp: any) => (
                    <TableRow key={opp.id_opportunity}>
                        <TableCell className="font-medium">
                            {opp.client?.company_name}
                        </TableCell>
                        <TableCell>{opp.type}</TableCell>
                        <TableCell>{opp.status}</TableCell>
                        <TableCell className="text-right">
                            $ {opp.amount}
                        </TableCell>
                    </TableRow>
                ))}
            </TableBody>
        </Table>
    );
}
